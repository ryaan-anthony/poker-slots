module PokerSlots
  class ViewModel
    def initialize(lines, winner = [])
      @lines = lines
      @winner = winner
    end

    def lines
      @lines.map.with_index do |line, row|
        line.map.with_index do |card, column|
          if @winner.include?([row, column])
            "[#{card.join}]"
          else
            " #{card.join} "
          end
        end.join('  ')
      end
    end
  end
end