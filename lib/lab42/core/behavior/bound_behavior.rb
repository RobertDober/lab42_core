require 'forwarder'
require_relative 'composition'
module Lab42
  module Behavior
    # Thank youn my dear Proxy, for sending me all the information
    # I, the clever guy, who is having all the fun, will make best
    # use of it by being an extremly, yes I said *extremly* clever
    # callable object representing the methods or instance methods
    # represented by the calls to `Object#fn` or `Module#fm`. 
    # Did I tell you yet? It is sooooo out not be functional...
    class BoundBehavior
      include Behavior
      attr_reader :args, :block, :method, :receiver

      extend Forwarder
      forward :arity, to: :method

      def call *a, &b
        method
        .( *(a + args), &(b||block) )
      end
      alias_method :[], :call

      def to_proc
        -> *a, &b do
          method
          .( *(a + args), &(b||block) )
        end
      end

      private
      def initialize receiver, method, *args, &block
        @receiver = receiver
        @method   = method
        @args     = args
        @block    = block
      end

    end # class BoundBehavior
  end # module Behavior
end # module Lab42
# SPDX-License-Identifier: Apache-2.0
