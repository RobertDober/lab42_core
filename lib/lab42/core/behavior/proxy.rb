require_relative 'unbound_behavior'
require_relative 'bound_behavior'
module Lab42
  module Behavior
    # Hey man really, that's all??? All my responsibility is to intercept
    # missing methods and sending them off to that Lab42::Behavior bloke,
    # having him have all the fun!!!! You cannott be serious by any known 
    # defintion of that term, or, can you .....
    class Proxy
      attr_reader :receiver, :fm
      private
      def initialize receiver, fm: false
        @receiver = receiver
        @fm       = fm
      end

      def method_missing *args, &blk
        fm ?
          Lab42::Behavior::UnboundBehavior.new( receiver, receiver.instance_method( args.first ), *args.drop(1), &blk ) :
          Lab42::Behavior::BoundBehavior.new( receiver, receiver.method( args.first ), *args.drop(1), &blk )
      end
    end # class Proxy
  end # module Behavior
end # module Lab42
# SPDX-License-Identifier: Apache-2.0
