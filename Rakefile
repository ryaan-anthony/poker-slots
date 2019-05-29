require './lib/autoloader'

desc "Play PokerSlots"
task :play, [:credits] do |t, args|
  input = STDIN
  output = PokerSlots::Renderer.new(STDOUT)
  game = PokerSlots::SlotMachine.new(args.credits.to_f.abs)
  PokerSlots::GameEngine.new(input, output, game).play
end

require 'rake/testtask'
Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_test.rb'
end
