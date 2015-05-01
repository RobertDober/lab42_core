module Lab42
  module Meta extend self
    def Behavior *args, &blk
      return blk if blk
      determine_behavior_from args
    end 

    private
    def determine_behavior_from args
      return make_callable args.last if args.last && args.last.respond_to?(  :call )
      return make_message_sender args if Symbol === args.first
      make_function args unless args.empty?
    end

    def make_callable callable
      return callable if Proc === callable
      -> *a, &b do
        callable.(*a, &b)
      end
    end

    def make_function args
      rcv = args.first
      -> *a, &b do
        rcv.send( *(args.drop(1) + a), &b )
      end
    end

    def make_message_sender args
      -> (rcv, *late_args) do
        rcv.send( args.first, *( late_args + args.drop(1) ) )
      end
    end
  end # module Meta
end # module Lab42
