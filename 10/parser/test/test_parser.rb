# frozen_string_literal: true

require "test_helper"
require "gyoku"

class TestParser < Minitest::Test
  def test_parse_simple_if
    result = Parser.call("test/fixtures/simple/if.jack")
    expected = File.read("test/fixtures/simple/if.xml")
    assert_equal(expected, result)
  end
end
