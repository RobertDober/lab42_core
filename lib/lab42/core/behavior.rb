require 'forwarder'

module Lab42
  class Behavior
    attr_reader :args, :method, :receiver

    extend Forwarder
    forward_all :call, :to_proc, :[], to: :method


    def arity
      @arity || method.arity
    end
    
    private
    def initialize receiver, method, *args
      @receiver = receiver
      @method   = method
      @args     = args
      curry
    end

    def curry
      return if args.empty?
      define_arity
      old_method = method
      @method = -> *a, &b do
        old_method.( *(a+args), &b ) 
      end
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
  end # class Behavior
end # module Lab42
