module PokerSlots
  class InvalidLine < StandardError; end
  class LineMatcher
    def initialize(line)
      @line = line
      raise InvalidLine unless valid?
    end

    def match_percent
      if full_match?
        1.0
      else
        half_match? ? 0.5 : 0.0
      end
    end

    def full_match?
      @line.uniq.count == 1
    end

    def half_match?
      @line.map(&:first).uniq.count == 1 || @line.map(&:last).uniq.count == 1
    end

    private

    def valid?
      @line.count == 3 && @line.map(&:count).uniq.first == 2
    end
  end
end