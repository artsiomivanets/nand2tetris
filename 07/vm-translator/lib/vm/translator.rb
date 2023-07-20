# frozen_string_literal: true

require_relative "translator/version"
require "pry"

module Vm
  module Translator
    class Error < StandardError; end

    module Commands
      def self.put_to_stack(_context)
        ["@SP", "A=M", "M=D"]
      end

      def self.put_to_memory(_context)
        ["M=D"]
      end

      def self.inc(_context)
        ["@SP", "M=M+1"]
      end

      def self.dec(_context)
        ["@SP", "M=M-1"]
      end

      def self.take_from_stack(_context)
        ["@SP", "A=M", "D=M"]
      end

      def self.sum_current(_context)
        ["A=M", "M=D+M"]
      end

      def self.branch(cond, t, f, context)
        ["A=M", "D=M-D", "@T_#{context[:counter]}", cond, f, "@END_#{context[:counter]}", "0;JMP",
         "(T_#{context[:counter]})", t, "(END_#{context[:counter]})"]
      end

      def self.set_minus_1_to_stack(context)
        ["D=-1"] + put_to_stack(context)
      end

      def self.set_0_to_stack(context)
        ["D=0"] + put_to_stack(context)
      end

      def self.eq(context)
        branch("D;JEQ", set_minus_1_to_stack(context), set_0_to_stack(context), context)
      end

      def self.lt(context)
        branch("D;JLT", set_minus_1_to_stack(context), set_0_to_stack(context), context)
      end

      def self.gt(context)
        branch("D;JGT", set_minus_1_to_stack(context), set_0_to_stack(context), context)
      end

      def self.and(_context)
        ["A=M", "M=D&M"]
      end

      def self.or(_context)
        ["A=M", "M=D|M"]
      end

      def self.sub(_context)
        ["A=M", "M=M-D"]
      end

      def self.not(_context)
        ["M=!D"]
      end

      def self.neg(_context)
        ["M=-D"]
      end

      def self.generate_memory_address(context)
        {
          constant: ->(v) { ["@#{v}"] },
          local: ->(v) { ["@LCL", "D=M", "@#{v}", "A=D+A"] },
          argument: ->(v) { ["@ARG", "D=M", "@#{v}", "A=D+A"] },
          this: ->(v) { ["@THIS", "D=M", "@#{v}", "A=D+A"] },
          that: ->(v) { ["@THAT", "D=M", "@#{v}", "A=D+A"] },
          temp: ->(v) { ["@#{5 + v.to_s.to_i}"] },
          pointer: ->(v) { [v.to_s.to_i.zero? ? "@THIS" : "@THAT"] },
          static: ->(v) { ["@#{context[:file_name]}.#{v}"] }
        }[context[:arg1]].call(context[:arg2])
      end

      def self.take_from_memory(context)
        if context[:arg1] == :constant
          ["D=A"]
        else
          ["D=M"]
        end
      end

      def self.save(_context)
        ["D=A"]
      end

      def self.save_pointer(_context)
        ["D=M"]
      end

      def self.put_to_temp_0(_context)
        ["@Temp0", "M=D"]
      end

      def self.put_to_temp_1(_context)
        ["@Temp1", "M=D"]
      end

      def self.save_from_temp_0_to_D(_context)
        ["@Temp0", "D=M"]
      end

      def self.save_from_temp_0_to_D(_context)
        ["@Temp0", "D=M"]
      end

      def self.save_from_temp_1_to_A(_context)
        ["@Temp1", "A=M"]
      end

      def self.generate_label(context)
        ["(#{context[:arg1]})"]
      end

      def self.non_eq_to_zero(context)
        take_from_stack(context) + ["@#{context[:arg1]}", "D;JNE"]
      end

      def self.jmp(context)
        ["@#{context[:arg1]}", "0;JMP"]
      end

      def self.return(context)
        set_end_frame_address = ["// SET END FRAME ADDRESS"] + ["@LCL", "D=M", "@Temp5", "M=D"]
        put_return_value_to_arg_zero = ["// Put return value to arg"] + dec(context) + take_from_stack(context) + [
          "@ARG", "A=M", "M=D"
        ]
        set_sp_as_arg = ["// Set SP as ARG"] + ["@ARG", "A=M", "D=A+1", "@SP", "M=D"]
        restore_that = ["// Restore THAT"] + ["@1", "D=A", "@Temp5", "A=M", "A=A-D", "D=M", "@THAT", "M=D"]
        restore_this = ["// Restore THIS"] + ["@2", "D=A", "@Temp5", "A=M", "A=A-D", "D=M", "@THIS", "M=D"]
        restore_arg = ["// Restore ARG"] + ["@3", "D=A", "@Temp5", "A=M", "A=A-D", "D=M", "@ARG", "M=D"]
        restore_lcl = ["// Restore LCL"] + ["@4", "D=A", "@Temp5", "A=M", "A=A-D", "D=M", "@LCL", "M=D"]
        set_return_address = ["// Set  return address"] + ["@5", "D=A", "@Temp5", "A=M", "D=A-D", "@Temp4", "M=D"]
        got_to_return_address = ["// Go to return address"] + ["@Temp4", "A=M", "A=M", "0;JMP"]
        [
          set_end_frame_address,
          set_return_address,
          put_return_value_to_arg_zero,
          set_sp_as_arg,
          restore_that,
          restore_this,
          restore_arg,
          restore_lcl,
          got_to_return_address
        ].flatten
      end

      def self.function(context)
        ["(#{context[:arg1]})"]
      end

      def self.call(context)
        save_return = ["@RETURN_#{context[:arg1]}_#{context[:counter]}"].map do |label|
          ["// SAVE #{label}", label, save(context), put_to_stack(context), inc(context)]
        end.flatten
        save_pointers = ["@LCL", "@ARG", "@THIS", "@THAT"].map do |label|
          ["// SAVE #{label}", label, save_pointer(context), put_to_stack(context), inc(context)]
        end.flatten
        set_arg = ["// SET ARG", "@#{context[:arg2]}", "D=A", "@SP", "A=M", "D=A-D", "@5", "D=D-A", "@ARG", "M=D"]
        set_lcl_to_sp = ["// SET LCL TO SP", "@SP", "D=M", "@LCL", "M=D"]
        go_to_function = ["// GO TO FUNCTION", "@#{context[:arg1]}", "0;JMP"]
        [save_return, save_pointers, set_arg, set_lcl_to_sp, go_to_function,
         "(RETURN_#{context[:arg1]}_#{context[:counter]})"].flatten
      end

      def self.bootstrap(_context)
        basic_pointers = {
          "SP" => 256,
          "LCL" => 300,
          "ARG" => 400,
          "THIS" => 3000,
          "THAT" => 3010
        }
        initialize_pointer_addresses = basic_pointers.map do |label, value|
          ["@#{value}", "D=A", "@#{label}", "M=D"]
        end.flatten
      end
    end

    module Main
      def self.generate_commands(context)
        commands_by_op = {
          push: %i[generate_memory_address take_from_memory put_to_stack inc],
          pop: %i[dec take_from_stack
                  put_to_temp_0
                  generate_memory_address
                  save
                  put_to_temp_1
                  save_from_temp_0_to_D
                  save_from_temp_1_to_A
                  put_to_memory],
          add: %i[dec take_from_stack dec sum_current inc],
          sub: %i[dec take_from_stack dec sub inc],
          eq: %i[dec take_from_stack dec eq inc],
          lt: %i[dec take_from_stack dec lt inc],
          gt: %i[dec take_from_stack dec gt inc],
          and: %i[dec take_from_stack dec and inc],
          or: %i[dec take_from_stack dec or inc],
          not: %i[dec take_from_stack not inc],
          neg: %i[dec take_from_stack neg inc],
          label: %i[generate_label],
          goto: %i[jmp],
          "if-goto": %i[dec non_eq_to_zero],
          return: %i[return],
          function: %i[function],
          bootstrap: %i[bootstrap],
          call: %i[call]
        }
        commands = commands_by_op[context[:op]]

        commands.map { |command_name| Commands.send(command_name, context) }
      end

      def self.prepare_dir_lines(path)
        all_vm_files = Dir.chdir(path) { Dir.glob("*.vm") }
        sys_file_name, programs_file_name = all_vm_files.partition { |i| i == "Sys.vm" }
        commands = [sys_file_name, programs_file_name].flatten.map do |p|
          IO.readlines(File.join(path, p), chomp: true)
        end.flatten
        ["bootstrap"] + commands
      end

      def self.call(path)
        lines = if File.directory?(path)
                  prepare_dir_lines(path)
                else
                  IO.readlines(path, chomp: true)
                end

        without_comments = remove_comments(lines)
        file_name = File.basename(path, ".*")

        parse(without_comments, file_name)
      end

      def self.remove_comments(lines)
        lines.reject { |line| line[0]&.include?("/") }&.reject(&:empty?)&.map { |s| s.split(%r{\s//\s})[0].strip }
      end

      def self.parse(lines, file_name)
        lines.map.with_index do |line, i|
          op, arg1, arg2 = line.split(" ").map(&:to_sym)
          context = { op: op, arg1: arg1, arg2: arg2, file_name: file_name, counter: i }
          commands = generate_commands(context)
          comment = "// #{line}"

          [comment, commands].compact
        end.flatten.join("\n") + "\n"
      end
    end
  end
end
