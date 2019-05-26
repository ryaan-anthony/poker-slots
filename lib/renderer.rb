module PokerSlots
  class Renderer
    SEPARATOR = '- - - - - - - - - - - -'.freeze

    def clear
      system 'clear'
    end

    def append(mixed)
      puts mixed
    end

    def display_intro(credits)
      clear
      append SEPARATOR
      append "   Credits: $#{'%.2f' % credits}"
      append SEPARATOR
      append '   Place your bet:'
    end

    def display_layout(wager, view, payout, credits)
      clear
      append SEPARATOR
      append "   Credits: $#{'%.2f' % credits}"
      append SEPARATOR
      view.lines.each { |line| append "   #{line}" }
      append SEPARATOR
      append "   Bet: $#{'%.2f' % wager}"
      append SEPARATOR
      append "   Win: $#{'%.2f' % payout}"
      append SEPARATOR
      append '[Press ENTER to rebet]'
    end
  end
end