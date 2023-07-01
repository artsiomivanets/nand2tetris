# frozen_string_literal: true

require "test_helper"

class Vm::TestTranslator < Minitest::Test
  def test_simple_add
    result = File.read("test/fixtures/SimpleAdd.asm")
    asm = Vm::Translator::Main.call("test/fixtures/SimpleAdd.vm")

    assert_equal(result, asm)
  end

  def test_stack
    result = File.read("test/fixtures/StackTest.asm")
    asm = Vm::Translator::Main.call("test/fixtures/StackTest.vm")

    assert_equal(result, asm)
  end
end
