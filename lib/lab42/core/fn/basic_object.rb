module Lab42
  module Core
    class Fn < BasicObject
      def self;
        ->(*args,&blk){ @source } # This is *not* a recursive call
      end
      private
      def initialize source
        @source = source
      end 

      def method_missing *args, &blk
        return @source.method args.first if args.size == 1 && blk.nil?
        s = @source
        -> *a, &b do
          s.method( args.first ).(*(args[1..-1]+a), &(blk||b))
        end
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
          m.bind( receiver ).(*(args[1..-1]+a), &(blk||b))
        end
      end
    end # class Fn
  end # module Core
end # module Lab42
