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
      append "   Bet: $#{'%.2f' % bet}"
      separator
      unless payout.nil?
        append "   Win: $#{'%.2f' % payout}"
        separator
      end
      append '[Press ENTER to rebet]'
    end
  end
end