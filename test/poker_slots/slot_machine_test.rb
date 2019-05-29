require './test/test_helper'

module PokerSlots
  class SlotMachineTest < Minitest::Test
    def setup
      @slot_machine = SlotMachine.new(100)
    end

    def test_credits
      assert_equal(@slot_machine.credits, 100)
    end

    def test_no_matches
      @slot_machine.stub :calculate_matches, [] do
        @slot_machine.spin(25)
        assert_equal(@slot_machine.credits, 75)
      end
    end

    def test_match_first_line
      @slot_machine.stub :calculate_matches, [[[[0,0], [0,1], [0,2]], 1.0]] do
        @slot_machine.spin(25)
        assert_equal(@slot_machine.credits, 125)
      end
    end

    def test_calculate_matches
      @slot_machine.stub :lines, [
        [[0,0], [0,1], [0,2]],
        [[1,0], [1,1], [1,2]],
        [[2,0], [2,1], [2,2]]
      ] do
        @slot_machine.spin(10)
        assert_equal(@slot_machine.credits, 150)
      end
    end
  end
end
