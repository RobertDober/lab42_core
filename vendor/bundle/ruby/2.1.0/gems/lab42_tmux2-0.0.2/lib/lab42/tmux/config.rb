module Lab42
  module Tmux
    class Config

      def self.define_setter_getter name
        define_method name do |*args|
          return instance_variable_get("@#{name}") if args.empty?
          instance_variable_set "@#{name}", args.first
        end
      end

      def self.define_setter_getters *names
        names.each do | name |
          define_setter_getter( name )
        end
      end

      define_setter_getters :pre_wait_interval, :post_wait_interval, :wait_interval, :wait_timeout
      define_setter_getters :session_name, :window_automatic_rename
      define_setter_getters :verbose

      private
      def initialize
        @wait_interval = 0.5
        @wait_timeout  = 2
      end
    end # module Config
  end # module Tmux
end # module Lab42
