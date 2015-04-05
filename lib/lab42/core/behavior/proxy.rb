require_relative '../behavior'
module Lab42
  class Behavior
    class Proxy
      attr_reader :receiver
      private
      def initialize receiver
        @receiver = receiver
      end

      def method_missing *args
        Lab42::Behavior.new receiver, receiver.method( args.first ), *args.drop(1)

      end
        
    end # class Proxy
  end # class Behavior
end # module Lab42
