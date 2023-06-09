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

      def self.generate_condition(context)
        take_from_stack(context) + ["@#{context[:arg1]}", "D;JGT"]
      end

      def self.jmp(context)
        ["@#{context[:arg1]}", "0;JMP"]
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
          "if-goto": %i[dec generate_condition]
        }
        commands = commands_by_op[context[:op]]

        commands.map { |command_name| Commands.send(command_name, context) }
      end

      def self.call(path_to_file)
        lines = IO.readlines(path_to_file, chomp: true)
        without_comments = remove_comments(lines)
        file_name = File.basename(path_to_file, ".*")

        parse(without_comments, file_name)
      end

      def self.remove_comments(lines)
        lines.reject { |line| line[0]&.include?("/") }.reject(&:empty?).map { |s| s.split(%r{\s//\s})[0].strip }
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
