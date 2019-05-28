module PokerSlots
  class FormatLines
    def initialize(lines, match = [])
      @lines = lines
      @match = match
    end

    def lines
      @lines.map.with_index do |line, row|
        line.map.with_index do |card, column|
          if @match.include?([row, column])
            "[#{card.join}]"
          else
            " #{card.join} "
          end
        end.join('  ')
      end
    end
  end
end