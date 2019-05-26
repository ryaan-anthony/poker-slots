module PokerSlots
  class PayoutCalculator
    attr_reader :payout

    def initialize(wager)
      @wager = wager
      @payout = 0
    end

    def calculate(line)
      percent = LineMatcher.new(line).match_percent
      @payout += (@wager * percent) * 2
      percent > 0
    end
  end
end