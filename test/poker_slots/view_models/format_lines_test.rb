require './test/test_helper'

module PokerSlots
  class FormatLinesTest < Minitest::Test
    EXAMPLE_LINES =  [
      [%w[A B], %w[C D], %w[E F]],
      [%w[1 2], %w[3 4], %w[5 6]]
    ].freeze

    def test_no_matching_lines
      assert_equal(
        FormatLines.new(EXAMPLE_LINES).lines,
        [
          ' AB    CD    EF ',
          ' 12    34    56 '
        ]
      )
    end

    def test_matching_lines
      assert_equal(
        FormatLines.new(EXAMPLE_LINES, [[0,0], [0,1], [0,2]]).lines,
        [
          '[AB]  [CD]  [EF]',
          ' 12    34    56 '
        ]
      )
    end
  end
end
