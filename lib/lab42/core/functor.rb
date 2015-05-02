require_relative 'functor/factory'
module Lab42
  class Functor
    attr_reader :args, :block, :callable, :message
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
end
