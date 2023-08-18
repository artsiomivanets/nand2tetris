# frozen_string_literal: true

require_relative "parser/version"

require "pry"

module Tokenizer
  KEYWORDS = %w[class construction method field static
                var int char boolean void true false null this
                let do if else while return]

  def self.process(c, acc)
    case acc[:state]
    when "common"
      return acc if [" ", "\n"].include?(c)

      return process(c, acc.merge(state: "comment")) if c == "/"

      return process(c, acc.merge(state: "symbol")) if %w[) ( } {].include?(c)

      process(c, acc.merge(state: "word"))
    when "comment"
      return acc unless c == "\n"

      process(c, acc.merge(state: "common"))
    when "symbol"
      word = { type: :symbol, value: c }
      acc.merge({ state: "common", word: "", words: acc[:words] + [word] })
    when "word"
      if c.match(/\w/)
        acc.merge(word: acc[:word] + c)
      else
        type = KEYWORDS.include?(acc[:word]) ? :keyword : :identifier
        word = { type: type, value: acc[:word] }
        acc.merge(state: "common", word: "", words: acc[:words] + [word])
      end
    end
  end

  def self.call(context)
    result = context[:symbols].split("").reduce({
                                                  state: "common",
                                                  words: [],
                                                  word: ""
                                                }) do |acc, c|
      process(c, acc)
    end
    result[:words]
  end
end

module Parser
  def self.parse(context)
    Tokenizer.call(context)
  end

  def self.call(path)
    symbols = if File.directory?(path)
                prepare_dir_lines(path)
              else
                File.read(path)
              end

    context = { path: path, symbols: symbols }
    parse(context)
  end
end
