# frozen_string_literal: true

require_relative "parser/version"

require "pry"

module Tokenizer
  def self.process(c, acc)
    case acc[:state]
    when "start"
      return acc if [" ", "\n"].include?(c)

      return process(c, acc.merge(state: "comment")) if c == "/"

      process(c, acc.merge(state: "word"))
    when "comment"
      return acc unless c == "\n"

      process(c, acc.merge(state: "start"))
    when "word"
      return acc unless %w[) ( } {].include?(c)

      word = acc[:word] + c
      words = acc[:words].push(word)
      acc.merge(word: "", words: words)

    end
  end

  def self.call(context)
    result = context[:symbols].split("").reduce({
                                                  state: "start",
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
