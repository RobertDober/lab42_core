
module Enumerable
  def mm *args
    map &B(*args)
  end
end
