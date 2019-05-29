module PokerSlots
  class GameEngine
    attr_reader :input, :output, :game

    def initialize(input, output, game)
      @input = input
      @output = output
      @game = game
    end

    def play
      bet = current_bet
      return false unless valid_bet?(bet)
      spin_result = game.spin(bet)
      render_sequences(spin_result)
      render_errors(spin_result)
      true
    end

    def intro
      renderer.display_intro(game.credits)
    end

    def exit
      renderer.display_exit
    end

    private

    def render_sequences(spin_result)
      spin_result.sequences.each.with_index(1) do |sequence, index|
        # Last sequence, display payout
        if index == spin_result.sequences.size
          renderer.display_layout(
            spin_result.credits,
            sequence,
            @bet,
            spin_result.payout
          )
        else
          renderer.display_layout(
            spin_result.original_credits,
            sequence,
            @bet
          )
          sleep game.delay
        end
      end
    end

    def render_errors(spin_result)
      spin_result.errors.each do |error_message|
        renderer.append(error_message)
      end
    end

    def renderer
      @renderer ||= Renderer.new(output)
    end

    def valid_bet?(bet)
      if bet <= 0
        renderer.append('Invalid wager!')
      elsif bet > game.credits
        renderer.append('Insufficient Funds!')
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