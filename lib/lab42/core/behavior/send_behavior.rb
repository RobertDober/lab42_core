module Lab42
  module Behavior
    class SendBehavior
      include Behavior
      attr_reader :args, :block, :method

      def arity; -1 end

      def call rcv, *a, &b
        rcv.send( method, *(a+args), &(b||block) )
      end

      def to_proc
        -> rcv, *a, &b do
          rcv.send( method, *(a+args), &(b||block) )
        end
      end

      private
      def initialize method, *args, &block
        @method = method
        @args   = args
        @block  = block
      end

    end # class SendBehavior
  end # module Behavior
end # module Lab42
