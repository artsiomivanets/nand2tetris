# frozen_string_literal: true

require_relative "translator/version"
c = 0

module Vm
  module Translator
    class Error < StandardError; end

    module Operations
      @c = 0
      def self.put_to_stack
        ["@SP", "A=M", "M=D"]
      end

      def self.inc
        ["@SP", "M=M+1"]
      end

      def self.dec
        ["@SP", "M=M-1"]
      end

      def self.take_from_stack
        ["@SP", "A=M", "D=M"]
      end

      def self.sum_current
        ["A=M", "M=D+M"]
      end

      def self.branch(cond, t, f)
        @c += 1
        ["A=M", "D=M-D", "@T_#{@c}", cond, f, "@END_#{@c}", "0;JMP", "(T_#{@c})", t, "(END_#{@c})"]
      end

      def self.set_minus_1_to_stack
        ["D=-1"] + put_to_stack
      end

      def self.set_0_to_stack
        ["D=0"] + put_to_stack
      end

      def self.eq
        branch("D;JEQ", set_minus_1_to_stack, set_0_to_stack)
      end

      def self.lt
        branch("D;JLT", set_minus_1_to_stack, set_0_to_stack)
      end

      def self.gt
        branch("D;JGT", set_minus_1_to_stack, set_0_to_stack)
      end

      def self.and
        ["A=M", "M=D&M"]
      end

      def self.or
        ["A=M", "M=D|M"]
      end

      def self.sub
        ["A=M", "M=M-D"]
      end

      def self.not
        ["M=!D"]
      end

      def self.neg
        ["M=-D"]
      end
    end

    module Main
      MEMORY_TABLE = {
        constant: ->(v) { ["@#{v}", "D=A"] }
      }

      OPS_TABLE = {
        push: %i[put_to_stack inc],
        pop: %i[put_to_stack inc],
        add: %i[dec take_from_stack dec sum_current inc],
        sub: %i[dec take_from_stack dec sub inc],
        eq: %i[dec take_from_stack dec eq inc],
        lt: %i[dec take_from_stack dec lt inc],
        gt: %i[dec take_from_stack dec gt inc],
        and: %i[dec take_from_stack dec and inc],
        or: %i[dec take_from_stack dec or inc],
        not: %i[dec take_from_stack not inc],
        neg: %i[dec take_from_stack neg inc]
      }

      def self.call(path_to_file)
        lines = IO.readlines(path_to_file, chomp: true)
        without_comments = remove_comments(lines)

        parse(without_comments)
      end

      def self.remove_comments(lines)
        lines.reject { |line| line.include?("//") }.reject(&:empty?)
      end

      def self.parse(lines)
        lines.map do |line|
          op, arg1, arg2 = line.split(" ").map(&:to_sym)
          memory_comands = MEMORY_TABLE[arg1]&.call(arg2)
          operation_commands = OPS_TABLE[op].map { |op_name| Operations.send(op_name) }
          comment = "// #{line}"

          [comment, memory_comands, operation_commands].compact
        end.flatten.join("\n") + "\n"
      end
    end
  end
end
