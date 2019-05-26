module PokerSlots
  class InvalidWager < StandardError; end
  class InsufficientFunds < StandardError; end
  class SlotMachine
    include CardLibrary
    attr_reader :balance

    def initialize(balance)
      @balance = balance
    end

    def spin(wager, &block)
      raise InvalidWager if wager <= 0
      raise InsufficientFunds if wager > @balance
      @lines = nil
      @balance -= wager
      (0..2).each do |column|
        block.call(lines.map { |line| line.take(column) }, 0.0)
      end
      payout = calculate_payout(wager, block).payout
      @balance += payout
      [lines, payout]
    end

    def calculate_payout(wager, block)
      PayoutCalculator.new(wager).tap do |calculator|
        mappings.each do |mapping|
          line = mapping.map do |position|
            row, column = position
            lines[row][column]
          end
          if calculator.calculate(line)
            block.call(lines, calculator.payout, mapping)
          end
        end
      end
    end

    private

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
