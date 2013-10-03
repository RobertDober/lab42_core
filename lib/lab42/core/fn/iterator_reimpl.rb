module Lab42
  module Core
    module IteratorReimpl
      def self.included into
        into.module_eval do
          alias_method :__lab42_core_iterator_map__, :map
          def map behavior=nil, &blk
            __lab42_core_iterator_map__(&(behavior||blk))
          end
          alias_method :__lab42_core_iterator_reduce__, :reduce
          def reduce behavior=nil, &blk
            if Symbol === behavior
              __lab42_core_iterator_reduce__ behavior
            else
              __lab42_core_iterator_reduce__(&(behavior||blk))
            end
          end

          alias_method :__lab42_core_iterator_inject__, :inject
          def inject value, behavior=nil, &blk
            if Symbol === behavior
              __lab42_core_iterator_inject__ value, behavior
            else
              __lab42_core_iterator_inject__(value, &(behavior||blk))
            end
          end
        end
      end
    end
  end # module Core
end # module Lab42
