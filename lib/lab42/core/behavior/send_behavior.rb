module Lab42
  module Behavior

    # Thank youn my dear Proxy, for sending me all the information
    # I, the clever guy, who is having all the fun, will make best
    # use of it by being an extremly, yes I said *extremly* clever
    # callable object representing the methods or instance methods
    # represented by the calls to `Object#fn` or `Module#fm`. 
    # Did I tell you yet? It is sooooo out not be functional...
    class SendBehavior
      attr_reader :args, :block, :method

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
