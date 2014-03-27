require 'lab42/core/behavior'

module Lab42
  module Core
    module IteratorReimpl

      
      def self.included into
        _self = self
        into.module_eval do
          alias_method :__lab42_core_iterator_map__, :map
          def map behavior=nil, &blk
            # p [behavior,blk]
            __lab42_core_iterator_map__(&(behavior||blk))
          end
          alias_method :__lab42_core_iterator_select__, :select
          def select behavior=nil, &blk
            __lab42_core_iterator_select__(&(behavior||blk))
          end
          alias_method :filter, :select

          alias_method :__lab42_core_iterator_inject__, :inject
          define_method :inject  do |*args, &blk|
            args, behavior = Lab42::Behavior.decompose_arguments args, blk
            __lab42_core_iterator_inject__( *args, &behavior )
          end
          alias_method :reduce, :inject

          def filter *args, &blk
          end
        end

      end
    end
  end # module Core
end # module Lab42
