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
  end # module Core
end # module Lab42
