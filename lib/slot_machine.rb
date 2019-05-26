module PokerSlots
  class InvalidWager < StandardError; end
  class InsufficientFunds < StandardError; end
  class SlotMachine
    include CardLibrary
    attr_reader :credits

    def initialize(credits)
      @credits = credits
    end

    def spin(wager, &block)
      raise InvalidWager if wager <= 0
      raise InsufficientFunds if wager > @credits
      @lines = nil
      @credits -= wager
      spin_animation(block)
      calculator = payout_calculator(wager)
      win_animation(calculator.winners, calculator.payout, block)
      @credits += calculator.payout
      [wrap(lines), calculator.payout]
    end

    def payout_calculator(wager)
      PayoutCalculator.new(wager).tap do |calculator|
        mappings.each do |mapping|
          line = mapping.map do |position|
            row, column = position
            lines[row][column]
          end
          calculator.add_winners(mapping) if calculator.calculate(line)
        end
      end
    end

    private

    def win_animation(winners, payout, block)
      winners.each do |winner|
        block.call(wrap(lines, winner), payout)
      end
    end

    def spin_animation(block)
      (0..2).each do |column|
        columns = lines.map { |line| line.take(column) }
        block.call(wrap(columns), 0.0)
      end
    end

    def wrap(lines, mapping = [])
      ViewModel.new(lines, mapping)
    end

    def mappings
      [
        [[0,0], [0,1], [0,2]], #row1
        [[1,0], [1,1], [1,2]], #row2
        [[2,0], [2,1], [2,2]], #row3
        [[0,0], [1,1], [2,2]], #diagonal1
        [[0,2], [1,1], [2,0]], #diagonal2
        [[0,0], [1,0], [2,0]], #column1
        [[0,1], [1,1], [2,1]], #column2
        [[0,2], [1,2], [2,2]]  #column3
      ]
    end

    def lines
      @lines ||= [
        [card, card, card],
        [card, card, card],
        [card, card, card]
      ]
    end
  end
end
