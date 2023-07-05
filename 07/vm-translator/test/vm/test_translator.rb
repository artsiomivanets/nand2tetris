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

  def test_basic_memory
    result = File.read("test/fixtures/BasicTest.asm")
    asm = Vm::Translator::Main.call("test/fixtures/BasicTest.vm")

    assert_equal(result, asm)
  end

  def test_pointer
    result = File.read("test/fixtures/PointerTest.asm")
    asm = Vm::Translator::Main.call("test/fixtures/PointerTest.vm")

    assert_equal(result, asm)
  end

  def test_static
    result = File.read("test/fixtures/StaticTest.asm")
    asm = Vm::Translator::Main.call("test/fixtures/StaticTest.vm")

    assert_equal(result, asm)
  end
end
