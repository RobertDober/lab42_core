module Lab42
  module Core
    module IteratorReimpl

      
      def self.decompose_args args, block
        raise ArgumentError, 'too many arguments' if args.size + ( block ? 1 : 0 ) > 2
        return [args,block] if block 
        b, a = args.partition{|x| behavior? x}
        behave = b.pop
        a = b if a.empty?
        raise ArgumentError, "No behavior specified" unless behave
        return [a,behave]
      end

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
            args, behavior = _self.decompose_args args, blk
            __lab42_core_iterator_inject__( *args, &behavior )
          end
          alias_method :reduce, :inject

          def filter *args, &blk
          end
        end

        private
        def self.behavior? x
          Symbol === x || Proc === x || Method === x
        end
      end
    end
  end # module Core
end # module Lab42
