module Lab42
  module Lazy extend self
    Never = Enumerator.new{}
    def once value
      Enumerator.new{ |y| y << value }
    end
  end # module Lazy
end # module Lab42
