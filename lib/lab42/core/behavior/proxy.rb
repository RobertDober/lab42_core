require_relative '../behavior'
require_relative '../unbound_behavior'
module Lab42
  class Behavior
    # Hey man really, that's all??? All my responsibility is to intercept
    # missing methods and sending them off to that Lab42::Behavior bloke,
    # having him have all the fun!!!! You cannott be serious by any known 
    # defintion of that term, or, can you .....
    class Proxy
      attr_reader :receiver, :fm
      private
      def initialize receiver, fm: false
        @receiver = receiver
        @fm       = fm
      end

      def method_missing *args, &blk
        fm ?
          Lab42::UnboundBehavior.new( receiver, receiver.instance_method( args.first ), *args.drop(1), &blk ) :
          Lab42::Behavior.new( receiver, receiver.method( args.first ), *args.drop(1), &blk )
      end
    end # class Proxy
  end # class Behavior
end # module Lab42
