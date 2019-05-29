require './lib/autoloader'

desc "Play PokerSlots"
task :play, [:credits] do |t, args|
  credits = args.credits.to_f.abs
  slot_machine = PokerSlots::SlotMachine.new(credits)
  game_engine = PokerSlots::GameEngine.new(STDIN, STDOUT, slot_machine)
  game_engine.intro
  loop { game_engine.play }
  game_engine.exit
end

desc "Audit PokerSlots::SlotMachine"
task :audit do
  puts 'Auditing PokerSlots::SlotMachine...'
  (0..1000).each do
    slot_machine = PokerSlots::SlotMachine.new(100)
    if (0..100).any? { slot_machine.spin(1).credits <= 0 }
      puts 'WARNING: OUT OF CREDITS IN 100 SPINS'
    end

    slot_machine = PokerSlots::SlotMachine.new(100)
    if (0..100).any? { slot_machine.spin(1).credits >= 200 }
      puts 'WARNING: DOUBLED CREDITS WITHIN 100 SPINS'
    end
  end
  puts 'Audit Complete!'
end

require 'rake/testtask'
Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_test.rb'
end
