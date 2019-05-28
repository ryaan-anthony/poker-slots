module PokerSlots
  class SpinResult
    attr_reader :sequences, :payout, :credits

    def initialize(sequences, payout, credits)
      @sequences = sequences
      @payout = payout
      @credits = credits
    end
  end
end