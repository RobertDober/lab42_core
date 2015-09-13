require_relative 'behavior'
require 'lab42/core/fn'

def B msg, *a, &b
  Lab42::Behavior::SendBehavior.new msg, *a, &b
end
