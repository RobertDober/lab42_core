
require_relative '../functor'

module Lab42
  class Functor
    module Factory extend self
      def method_missing *a, &b
        Functor.new *a, &b
      end
    end # module Factory
  end
  class MethodFunctor < Functor
    module Factory extend self
      def method_missing *a, &b
        MethodFunctor.new *a, &b
      end
    end
  end # class MethodFunctor
end # module Lab42
