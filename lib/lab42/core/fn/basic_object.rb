module Lab42
  module Core
    class Fn < BasicObject
      private
      def initialize source
        @source = source
      end 

      def method_missing *args, &blk
        @source.method args.first
      end
    end # class Fn
    class Fm < BasicObject
      private
      def initialize source
        @source = source
      end 

      def method_missing *args, &blk
        m = @source.instance_method args.first
        -> receiver, *a, &b do
          m.bind( receiver ).(*a, &b)
        end
      end
    end # class Fn
  end # module Core
end # module Lab42
