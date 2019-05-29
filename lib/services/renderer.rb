module PokerSlots
  class Renderer
    SEPARATOR = '- - - - - - - - - - - -'.freeze

    def initialize(output)
      @output = output
    end

    def clear
      system 'clear'
    end

    def separator
      append SEPARATOR
    end

    def append(mixed)
      @output.puts mixed
    end

    def display_intro(credits)
      clear
      separator
      append "   Credits: $#{'%.2f' % credits}"
      separator
      append '   Place your bet:'
    end

    def display_exit
      clear
      separator
      append 'Thanks for playing!'
    end

    def display_layout(credits, sequence, bet, payout = nil)
      clear
      separator
      append "   Credits: $#{'%.2f' % credits}"
      separator
      sequence.lines.each { |line| append "   #{line}" }
      separator
      if payout.nil?
        append "   Bet: $#{'%.2f' % bet}"
        separator
      else
        append "   Win: $#{'%.2f' % payout}"
        separator
        append '[Press ENTER to rebet]'
      end
    end
  end
end