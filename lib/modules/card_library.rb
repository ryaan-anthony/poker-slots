module PokerSlots
  module CardLibrary
    NUMBERS = %w[J Q K A].freeze
    SUITS = %w[♣ ♠ ♦ ♥].freeze

    private

    def card
      [number, suit]
    end

    def number
      NUMBERS.sample
    end

    def suit
      SUITS.sample
    end
  end
end
