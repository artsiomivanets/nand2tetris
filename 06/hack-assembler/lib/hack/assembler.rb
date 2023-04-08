require 'hack/assembler/version'

class Integer
  def to_binary
    to_s(2).rjust(16, '0')
  end
end

module Hack
  module Assembler
    class Error < StandardError; end

    module Main
      DEST_SYM_TABLE = {
        'M' => '001',
        'D' => '010',
        'DM' => '011',
        'MD' => '011',
        'A' => '100',
        'AM' => '101',
        'AD' => '110',
        'ADM' => '111'
      }

      JUMP_TABLE = {
        'JGT' => '001',
        'JEQ' => '010',
        'JGE' => '011',
        'JLT' => '100',
        'JNE' => '101',
        'JLE' => '110',
        'JMP' => '111'
      }

      COMP_SYM_TABLE = {
        '0' => '101010',
        '1' => '111111',
        '-1' => '111010',
        'D' => '001100',
        'A' => '110000',
        'M' => '110000',
        '!D' => '001101',
        '!A' => '110001',
        '!M' => '110001',
        '-D' => '001111',
        'D+1' => '011111',
        'A+1' => '110111',
        'M+1' => '110111',
        'D-1' => '001110',
        'A-1' => '110010',
        'M-1' => '110010',
        'D+A' => '000010',
        'D+M' => '000010',
        'D-A' => '010011',
        'D-M' => '010011',
        'A-D' => '000111',
        'M-D' => '000111',
        'D&A' => '000000',
        'D&M' => '000000',
        'D|A' => '111111',
        'D|M' => '111111'
      }

      SYMBOLS_TABLE = {
        'R0' => 0.to_binary,
        'R1' => 1.to_binary,
        'R2' => 2.to_binary,
        'SCREEN' => 16_384.to_binary,
        'KBD' => 24_576.to_binary
      }

      def self.call(path_to_file)
        lines = IO.readlines(path_to_file, chomp: true)
        without_comments = remove_comments(lines)
        without_symbols = extract_symbols(without_comments)

        parse(without_symbols)
      end

      def self.remove_comments(lines)
        lines
          .map { |line| line.gsub(%r{/.*| }, '') }
          .compact
          .select { |i| !i.empty? }
      end

      def self.translate_c_instruction(h)
        jump_binary = begin
          JUMP_TABLE.fetch(h[:jmp].to_s)
        rescue StandardError
          '000'
        end
        dest_binary = begin
          DEST_SYM_TABLE.fetch(h[:dest].to_s)
        rescue StandardError
          '000'
        end
        computation_binary = COMP_SYM_TABLE.fetch(h[:computation].to_s)
        ismemory = h[:computation].to_s.include?('M') ? '1' : '0'
        "111#{ismemory}#{computation_binary}#{dest_binary}#{jump_binary}"
      end

      def self.extract_symbols(lines)
        memory_index = 16
        index = 0
        lines.map do |line|
          if (res = line.match(/\((?<label>.*)\)/))
            SYMBOLS_TABLE[res[:label].to_s] = index.to_binary
            nil
          elsif (res = line.match(/(?<symbol>((?<=@)[a-z]+))/))
            sym = if SYMBOLS_TABLE[res[:symbol].to_s]
                    SYMBOLS_TABLE[res[:symbol].to_s]
                  else
                    SYMBOLS_TABLE[res[:symbol].to_s] = memory_index
                    memory_index += 1
                    SYMBOLS_TABLE[res[:symbol].to_s]
                  end
            index += 1
            "@#{sym}"
          else
            index += 1
            line
          end
        end.compact
      end

      def self.parse(lines)
        lines.map do |line|
          if (res = line.match(/(?<number>((?<=@)[0-9]+))/))
            res[:number].to_i.to_binary
          elsif (res = line.match(/(?<symbol>((?<=@)\w+))/))
            SYMBOLS_TABLE.fetch(res[:symbol].to_s)
          elsif (res = line.match(/(?<dest>(.+(?==)))=(?<computation>((?<==).+(?=;)));(?<jmp>((?<=;).+(?=)))/))
            translate_c_instruction(res)
          elsif (res = line.match(/(?<computation>(.+(?=;)));(?<jmp>((?<=;).+(?=)))/))
            translate_c_instruction(res)
          elsif (res = line.match(/(?<dest>(.+(?==)))=(?<computation>((?<==).+(?=)))/))
            translate_c_instruction(res)
          end
        end.compact.join("\n") + "\n"
      end
    end
  end
end
