require 'forwarder'

module Lab42
  # Thank youn my dear Proxy, for sending me all the information
  # I, the clever guy, who is having all the fun, will make best
  # use of it by being an extremly, yes I said *extremly* clever
  # callable object representing the methods or instance methods
  # represented by the calls to `Object#fn` or `Module#fm`. 
  # Did I tell you yet? It is sooooo out not be functional...
  class Behavior
    attr_reader :args, :block, :method, :receiver

    extend Forwarder
    forward_all :call, :to_proc, :[], to: :method


    def arity
      @arity || method.arity
    end

    private
    def initialize receiver, method, *args, &block
      @receiver = receiver
      @method   = method
      @args     = args
      @block    = block
      curry
    end

    def curry
      return only_block_curry if args.empty?
      define_arity
      redefine_method method
    end

    def define_arity
      @arity =
        if method.arity < 1
          [method.arity + args.size, -1].min
        elsif method.arity >= args.size
          method.arity - args.size
        else
          raise ArgumentError "#{args.size} args instead of #{method.arity}"
        end
    end

    def only_block_curry
      return unless block
      redefine_method method
    end

    def redefine_method old_method
      @method = 
        -> *a, &b do
          old_method.( *(a+args), &(b||block) ) 
        end
    end

  end # class Behavior
end # module Lab42
