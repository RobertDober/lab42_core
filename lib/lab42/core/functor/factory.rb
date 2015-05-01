
require_relative '../functor'

module Lab42
  class Functor
    module Factory extend self
      def method_missing *a, &b
        Functor.new *a, &b
      end
    end # module Factory
  end # class Functor
end # module Lab42
