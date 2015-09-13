require 'forwarder'
module Lab42
  module Behavior
    class ProcBehavior
      include Behavior
      attr_reader :behavior

      extend Forwarder
      forward_all :arity, :call, :to_proc, to: :behavior

      private
      def initialize proc=nil, &blk
        @behavior = proc || blk || ->{}
      end
    end # class ProcBehavior

    class ::Proc
      def to_behavior
        Lab42::Behavior::ProcBehavior.new self
      end
    end
  end # module Behavior
end # module Lab42
