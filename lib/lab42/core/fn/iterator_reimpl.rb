module Lab42
  module Core
    module IteratorReimpl
      def self.included into
        into.module_eval do
          alias_method :__lab42_core_iterator_map__, :map
          def map behavior=nil, &blk
            __lab42_core_iterator_map__(&(behavior||blk))
          end
        end
      end
    end
  end # module Core
end # module Lab42
