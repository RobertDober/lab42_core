require_relative 'functor/factory'
require_relative 'functor/is_a_proc'
module Lab42
  class Functor
    attr_reader :args, :block, :callable, :message
    include IsAProc

    def call *a, &b
      return callable.( *(args + a), &(block || b) )  if callable
      # No CT argument
      a.first.send( message, *a.drop(1), &(block || b) )
    end

    private
    # if we have at least one argument we bind the message to it
    def initialize message, *args, &block
      @block    = block
      @message  = message
      @callable = !args.empty? && args.first.method( message )
      @args     = args.drop 1
    end
  end # class Functor

  class MethodFunctor < Functor
    def call *a, &b
      a.first.send( message, *(args + a.drop(1)), &(block || b) )
    end
    private
    def initialize message, *args, &block
      @block   = block
      @message = message
      @args    = args
    end
  end # class MethodFunctor
end
