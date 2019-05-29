module PokerSlots
  class GameEngine
    attr_reader :input, :output, :game

    def initialize(input, output, game)
      @input = input
      @output = output
      @game = game
    end

    def play
      output.display_intro(game.credits)
      loop do
        bet = current_bet
        next unless valid_bet?(bet)
        current_credits = game.credits - bet
        spin_result = game.spin(bet)

        spin_result.sequences.each.with_index(1) do |sequence, index|
          last_sequence = index == spin_result.sequences.size
          output.display_layout(
            sequence,
            bet,
            last_sequence ? spin_result.payout : 0,
            last_sequence ? spin_result.credits : current_credits
          )
          sleep game.delay
        end
      end
    end

    private

    def valid_bet?(bet)
      if bet <= 0
        output.append('Invalid wager!')
      elsif bet > game.credits
        output.append('Insufficient Funds!')
      else
        true
      end
    end

    def current_bet
      bet = input.gets
      # If user hits ENTER then re-submit the last bet
      unless bet == "\n" && defined?(@bet)
        @bet = bet.to_f.abs
      end
      @bet
    end
  end
end