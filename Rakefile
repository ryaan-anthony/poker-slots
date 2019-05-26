Dir[File.join(__dir__, 'lib', 'modules', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

desc "Play PokerSlots"
task :play, [:balance] do |t, args|
  renderer = PokerSlots::Renderer.new
  PokerSlots::SlotMachine.new(args.balance.to_f.abs).tap do |slot_machine|
    renderer.display_intro(slot_machine.balance)
    loop do
      input = STDIN.gets
      # If user hits ENTER then rebet the last bet
      unless input == "\n" && defined?(@wager)
        @wager = input.to_f.abs
      end

      begin
        lines, payout = slot_machine.spin(@wager) do |lines, payout, mapping = []|
          renderer.display_layout(@wager, lines, payout, slot_machine.balance, mapping)
          sleep 1
        end
        renderer.display_layout(@wager, lines, payout, slot_machine.balance)
      rescue PokerSlots::InvalidWager
        renderer.append('Invalid wager!')
      rescue PokerSlots::InsufficientFunds
        renderer.append('Insufficient Funds!')
      end
    end
  end
end
