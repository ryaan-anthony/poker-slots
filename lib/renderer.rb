module PokerSlots
  class Renderer
    SEPARATOR = '- - - - - - - - - - -'.freeze

    def clear
      system 'clear'
    end

    def append(mixed)
      puts mixed
    end

    def display_intro(balance)
      clear
      append SEPARATOR
      append "  Credits: $#{'%.2f' % balance}"
      append SEPARATOR
      append "  Place your bet:"
    end

    def display_layout(wager, lines, payout, balance, mapping = [])
      clear
      append SEPARATOR
      append "  Credits: $#{'%.2f' % balance}"
      append SEPARATOR
      lines.map.with_index do |line, row|
        output = line.map.with_index do |card, column|
          if mapping.include?([row, column])
            "[#{card.join}]"
          else
            " #{card.join} "
          end
        end
       append "  #{output.join('  ')}"
      end
      append SEPARATOR
      append "  Bet: $#{'%.2f' % wager}"
      append SEPARATOR
      append "  Win: $#{'%.2f' % payout}"
      append SEPARATOR
      append '[Press ENTER to rebet]'
    end
  end
end