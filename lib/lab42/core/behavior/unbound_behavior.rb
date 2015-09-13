require_relative 'composition'
module Lab42
  module Behavior

    # Thank youn my dear Proxy, for sending me all the information
    # I, the clever guy, who is having all the fun, will make best
    # use of it by being an extremly, yes I said *extremly* clever
    # callable object representing the methods or instance methods
    # represented by the calls to `Object#fn` or `Module#fm`. 
    # Did I tell you yet? It is sooooo out not be functional...
    class UnboundBehavior
      include Behavior
      attr_reader :args, :block, :method
      
      # Increment method's arity by one as we need to bind the
      # first argument to the method
      def arity
        method.arity.succ
      end

      def call *a, &b
        available_args = a + args
        m = method.bind available_args.first
        m.( *available_args.drop(1), &(b||block) )
      end

      def to_proc
        -> *a, &b do
          available_args = a + args
          method.bind( available_args.first )
          .( *available_args.drop(1), &(b||block) )
        end
      end

      # Rebinding:
      # We still apply our LIFO policy! So much for the proverbial
      # "The early bird catches the worm"? Anyway, what would I do
      # with a worm??? (Mescal maybe?)
      def _ *a, &b
        self.class.new @klass, method, *(a + args), &(b||block)
      end

      private
      def initialize klass, method, *args, &block
        @klass  = klass
        @method = method
        @args   = args
        @block  = block
      end

    end # class UnboundBehavior
  end # module Behavior
end # module Lab42
