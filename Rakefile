Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require file }

desc "Play PokerSlots"
task :play, [:credits] do |t, args|
  input = STDIN
  game = PokerSlots::SlotMachine.new(args.credits.to_f.abs)
  output = PokerSlots::Renderer.new
  PokerSlots::GameEngine.new(input, output, game).play
end
