require 'lab42/core/fn'
require 'forwarder'
module Lab42
  module Core
    class OpenObject
      extend Forwarder
      include Enumerable

      forward_all :keys, :values, to: :@data

      def == other
        self.class === other && to_hash == other.to_hash
      end
      def each &blk
        @data.each do | k, v |
          blk.( self.class.new k => v )
        end
      end

      def to_hash
        @data.clone
      end
      def update **params
        new_params = @data.merge params
        self.class.new( **new_params )
      end
      alias_method :merge, :update


      private
      def initialize( **params )
        @data = params
        params.each do |k, v|
          class << self; self end.module_eval do
            define_method(k){v}
          end
        end
      end

      class << self
        def inherited *args, **kwds, &blk
          raise RuntimeError, "I prefer delegation to inheritance, if you do not, MP me"
        end
      end
    end # class OpenObject
  end # module Core
end # module Lab42
