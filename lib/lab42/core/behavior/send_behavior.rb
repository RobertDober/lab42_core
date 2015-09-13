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

      # Rebinding:
      # We still apply our LIFO policy! So much for the proverbial
      # "The early bird catches the worm"? Anyway, what would I do
      # with a worm??? (Mescal maybe?)
      def _ *a, &b
        self.class.new method, *(a + args), &(b||block)
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
