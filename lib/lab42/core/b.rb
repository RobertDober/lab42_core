require_relative 'behavior'
require 'lab42/core/fn'

def B msg, *a, &b
  # TODO: Make Composable Behavior 
  -> rcv, *args, &blk do
    beh = b || blk
    rcv.send( msg, *(a+args), &beh)
  end
end
