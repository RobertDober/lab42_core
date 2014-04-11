require 'lab42/core/behavior_args'


module Enumerable
  def grep2 expr
    partition{ |ele| expr === ele }
  end
  alias_method :__orig_partition_lab42_core_enumerable__, :partition
  def partition *args, &blk
    args, beh = Lab42::Core::BehaviorArgs.decompose_arguments args, blk
    raise ArgumentError, 'no behavior specified' unless beh
    raise ArgumentError, "non behavior arguments not allowed but provided #{args.inspect}" unless args.empty?
    __orig_partition_lab42_core_enumerable__( &beh )
  end

  alias_method :__orig_take_while__, :take_while
  def take_while &blk
    return __orig_take_while__(&blk) if blk.arity.between? 0, 1
    inject [] do | result, ele |
      return result unless blk.(ele, result)
      result << ele
    end
  end

  def take_until &blk
    take_while( &(blk.not) )
  end
end

class Array
  alias_method :__orig_take_while__, :take_while
  remove_method :take_while
end
