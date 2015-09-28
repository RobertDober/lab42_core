module Lab42
  module Meta
    module Behavior extend self
      def behavior *args, &blk
        return blk if blk
        determine_behavior_from args
      end 

      def call_with_arity blk, params, base_arity: 1
        return blk.(*params.first(base_arity)) if blk.arity < 0
        blk.(*params.first(blk.arity))
      end

      private
      def determine_behavior_from args
        return make_callable args.last if args.last && args.last.respond_to?(  :call )
        return make_message_sender args if Symbol === args.first
      end

      def make_callable callable
        return callable if Proc === callable
        -> *a, &b do
          callable.(*a, &b)
        end
      end

      def make_message_sender args
        -> (rcv, *late_args) do
          rcv.send( args.first, *( late_args + args.drop(1) ) )
        end
      end
    end # module Behavior
  end # module Meta
end # module Lab42
