# frozen_string_literal: true

require "test_helper"

class Vm::TestTranslator < Minitest::Test
  # def test_simple_add
  #   result = File.read("test/fixtures/SimpleAdd.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/SimpleAdd.vm")
  #
  #   assert_equal(result, asm)
  # end
  #
  # def test_stack
  #   result = File.read("test/fixtures/StackTest.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/StackTest.vm")
  #
  #   assert_equal(result, asm)
  # end
  #
  # def test_basic_memory
  #   result = File.read("test/fixtures/BasicTest.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/BasicTest.vm")
  #
  #   assert_equal(result, asm)
  # end
  #
  # def test_pointer
  #   result = File.read("test/fixtures/PointerTest.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/PointerTest.vm")
  #
  #   assert_equal(result, asm)
  # end
  #
  # def test_static
  #   result = File.read("test/fixtures/StaticTest.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/StaticTest.vm")
  #
  #   assert_equal(result, asm)
  # end
  #
  # def test_basic_loop
  #   result = File.read("test/fixtures/BasicLoop.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/BasicLoop.vm")
  #   assert_equal(result, asm)
  # end
  #
  # def test_fibonacci
  #   result = File.read("test/fixtures/FibonacciSeries.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/FibonacciSeries.vm")
  #
  #   assert_equal(result, asm)
  # end
  #
  # def test_simple_function
  #   result = File.read("test/fixtures/SimpleFunction.asm")
  #   asm = Vm::Translator::Main.call("test/fixtures/SimpleFunction.vm")
  #
  #   assert_equal(result, asm)
  # end

  # def test_fibonacci_function_with_bootstrapping
  #   result = File.read("test/fixtures/FbonacciElement")
  #   asm = Vm::Translator::Main.call("test/fixtures/FibonacciElement")
  #
  #   assert_equal(result, asm)
  # end

  def test_nested_call
    # result = File.read("test/fixtures/FbonacciElement")
    asm = Vm::Translator::Main.call("test/fixtures/Sys.vm")
    File.write("test/fixtures/Sys.asm", asm)

    # assert_equal(result, asm)
  end
end
