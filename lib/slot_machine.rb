module PokerSlots
  class SlotMachine
    include CardLibrary
    SEQUENCE_DELAY = 0.8.freeze
    attr_reader :credits

    def initialize(credits)
      @credits = credits
    end

    def spin(bet)
      @lines = nil
      original_credits = @credits
      @credits -= bet

      matches = calculate_matches
      winners = matches.map(&:first)
      sequences =
        spin_animation +
        win_animation(winners) +
        final_animation

      payout_amount = matches.map(&:last).sum * random_multiplier
      payout_amount *= bet
      @credits += payout_amount

      previous_payout = (@previous_payout ||= 0)
      @previous_payout = payout_amount

      spin_result.new(
        sequences,
        payout_amount,
        credits,
        original_credits,
        previous_payout,
        []
      )
    end

    def delay
      SEQUENCE_DELAY
    end

    private

    # random number between 1.1 and 2.2
    def random_multiplier
      (rand(1..12) * 0.1) + 1
    end

    def spin_result
      Struct.new(
        :sequences,
        :payout,
        :credits,
        :original_credits,
        :previous_payout,
        :errors
      )
    end

    def calculate_matches
      mappings.each_with_object([]) do |mapping, matches|
        line = mapping.map do |position|
          row, column = position
          lines[row][column]
        end
        match_percent = LineMatcher.new(line).match_percent
        if match_percent > 0
          matches << [mapping, match_percent]
        end
      end
    end

    def spin_animation
      (0..2).map do |column|
        columns = lines.map { |line| line.take(column) }
        FormatLines.new(columns)
      end
    end

    def win_animation(winners)
      winners.map do |winner|
        FormatLines.new(lines, winner)
      end
    end

    def final_animation
      [
        FormatLines.new(lines)
      ]
    end

    def mappings
      [
        [[0,0], [0,1], [0,2]], #row1
        [[1,0], [1,1], [1,2]], #row2
        [[2,0], [2,1], [2,2]], #row3
        [[0,0], [1,1], [2,2]], #diagonal1
        [[0,2], [1,1], [2,0]], #diagonal2
        [[0,0], [1,0], [2,0]], #column1
        [[0,1], [1,1], [2,1]], #column2
        [[0,2], [1,2], [2,2]]  #column3
      ]
    end

    def lines
      @lines ||= [
        [card, card, card],
        [card, card, card],
        [card, card, card]
      ]
    end
  end
end
