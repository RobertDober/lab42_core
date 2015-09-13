
module Lab42
  module Behavior
    module Negation
      def negated
        ProcBehavior.new do |*args, &blk|
          !self.(*args, &blk)
        end
      end
    end # module Composition
    include Negation
  end # class Behavior
end # module Lab42
