module Enumerable
  def grep2 expr
    partition{ |ele| expr === ele }
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
