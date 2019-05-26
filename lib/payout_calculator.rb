module PokerSlots
  class PayoutCalculator
    attr_reader :payout, :winners

    def initialize(wager)
      @wager = wager
      @payout = 0
      @winners = []
    end

    def add_winners(winner)
      @winners << winner
    end

    def calculate(line)
      percent = LineMatcher.new(line).match_percent
      @payout += (@wager * percent) * 2
      percent > 0
    end
  end
end