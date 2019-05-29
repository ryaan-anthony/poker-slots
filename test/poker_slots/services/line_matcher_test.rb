require './test/test_helper'

module PokerSlots
  class LineMatcherTest < Minitest::Test
    def test_invalid_line
      assert_raises(InvalidLine) { LineMatcher.new([]) }
      assert_raises(InvalidLine) { LineMatcher.new([1, 2, 3]) }
    end

    def test_valid_line
      assert(LineMatcher.new([[1, 1], [2, 2], [3, 3]]))
    end
  end
end