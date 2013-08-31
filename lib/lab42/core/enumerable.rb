module Enumerable
  def grep2 expr
    partition{ |ele| expr === ele }
  end
end
