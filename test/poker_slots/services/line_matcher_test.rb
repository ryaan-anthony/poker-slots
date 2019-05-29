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

    def test_match_percent
      assert_equal(LineMatcher.new([[1, 2], [1, 2], [1, 2]]).match_percent, 1.0)
      assert_equal(LineMatcher.new([[1, 2], [1, 3], [1, 4]]).match_percent, 0.5)
      assert_equal(LineMatcher.new([[1, 4], [2, 4], [3, 4]]).match_percent, 0.5)
    end
  end
end