module Lab42
  module Core
    class Behavior

      private
      def initialize *args, &blk
        set_proc!( *args, &blk )
      end

      def set_proc! *args, &blk
      end

      
    end # class Behavior
  end # module Core
end # module Lab42
