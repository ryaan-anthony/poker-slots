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

    def display_layout(sequence, bet, payout, credits)
      clear
      separator
      append "   Credits: $#{'%.2f' % credits}"
      separator
      sequence.lines.each { |line| append "   #{line}" }
      separator
      append "   Bet: $#{'%.2f' % bet}"
      separator
      append "   Win: $#{'%.2f' % payout}"
      separator
      append '[Press ENTER to rebet]'
    end
  end
end