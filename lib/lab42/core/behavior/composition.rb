
module Lab42
  module Behavior
    module Composer extend self
      def zero_arity_composition lhs, rhs
        Lab42::Behavior::ProcBehavior.new do |*args, &blk|
          lhs.( *args, &blk )
          rhs.()
        end
      end
      def arg_passing_composition lhs, rhs
        Lab42::Behavior::ProcBehavior.new do |*args, &blk|
          rhs
          .( lhs
            .( *args, &blk ) )
        end
      end
    end # module Composer

    module Composition
      def | behavior
        if behavior.arity.zero?
          Composer.zero_arity_composition self, behavior
        else
          Composer.arg_passing_composition self, behavior
        end
      end
    end # module Composition
    include Composition
  end # class Behavior
end # module Lab42
