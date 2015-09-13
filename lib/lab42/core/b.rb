require 'lab42/core/fn'
require_relative 'behavior'

def B msg, *a, &b
  Lab42::Behavior::SendBehavior.new msg, *a, &b
end

Identity = Lab42::Behavior::ProcBehavior.new{ |x| x }
