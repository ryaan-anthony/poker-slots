module PokerSlots
  autoload :CardLibrary,      './lib/libraries/card_library'
  autoload :GameEngine,       './lib/game_engine'
  autoload :FormatLines,      './lib/view_models/format_lines'
  autoload :InvalidLine,      './lib/services/line_matcher'
  autoload :LineMatcher,      './lib/services/line_matcher'
  autoload :Renderer,         './lib/services/renderer'
  autoload :SlotMachine,      './lib/slot_machine'
  autoload :SpinResult,       './lib/models/spin_result'
end