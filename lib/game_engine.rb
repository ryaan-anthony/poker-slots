module PokerSlots
  class GameEngine
    attr_reader :input, :game, :output

    def initialize(input, game, output)
      @input = input
      @game = game
      @output = output
    end

    def play
      output.display_intro(game.credits)
      loop do
        bet = current_bet
        begin
          lines, payout = game.spin(bet) do |lines, payout|
            output.display_layout(bet, lines, payout, game.credits)
            sleep 0.8
          end
          output.display_layout(bet, lines, payout, game.credits)
        rescue PokerSlots::InvalidWager
          output.append('Invalid wager!')
        rescue PokerSlots::InsufficientFunds
          output.append('Insufficient Funds!')
        end
      end
    end

    private

    def current_bet
      bet = input.gets
      # If user hits ENTER then rebet the last bet
      unless bet == "\n" && defined?(@bet)
        @bet = bet.to_f.abs
      end
      @bet
    end
  end
end