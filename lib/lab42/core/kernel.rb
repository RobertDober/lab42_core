
require_relative './behavior'

def Fn *args, &blk
  Lab42::Core::Behavior.new( *args, &blk )
end
