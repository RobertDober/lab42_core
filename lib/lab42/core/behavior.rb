module Lab42
  module Behavior

    def const_lambda a_const
      -> *a, &b do
        a_const
      end
    end

    def sendmsg *args
      ->(*a){ a.first.send(*(args + a.drop( 1 ))) }
    end

    def can_be_behavior? x
      Symbol === x || Proc === x || Method === x
    end

    # behavior is either the block or the last argument that qualifies as a behavior.
    # The arguments are either all non behavior arguments or all but the last argument
    # if all arguments are behaviors.
    def decompose_arguments args, block
      raise ArgumentError, 'too many arguments' if args.size + ( block ? 1 : 0 ) > 2
      return [args,block] if block 
      b, a = args.partition{ |arg| Behavior.can_be_behavior? arg }
      behave = b.pop
      a = b if a.empty?
      raise ArgumentError, "No behavior specified" unless behave
      return [a,behave]
    end
  end # module Behavior
end # module Lab42
