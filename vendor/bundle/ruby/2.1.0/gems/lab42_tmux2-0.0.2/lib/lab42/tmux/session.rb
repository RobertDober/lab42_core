require_relative 'errors'
require_relative 'session/commands'
require_relative 'session/hooks'

require 'forwarder'

module Lab42
  module Tmux
    class Session

      attr_reader :commands, :configuration, :session_name, :window_number

      extend Forwarder
      forward_all :command, :query, to_object: Interface

      def config &block
        block.( configuration )
      end
    
      def run &block
        return attach if running?
        create_session
        instance_exec( &block )
        attach
      end


      private
      def initialize sess_name
        @session_name = sess_name
        @window_number = 0
        @commands = []
        @configuration = $config || Config.new

        self.class.instance self
      end

      def attach
        command 'attach-session', '-t', session_name
      end

      def create_session
        command 'source-file', File.join( ENV["HOME"], '.tmux.conf' )
        # TODO: replace 'sh' with a configuration value
        command 'new-session', '-d', '-s', session_name, '-n', 'sh'
        command 'set-window-option', '-g', 'automatic-rename', 'off' unless configuration.window_automatic_rename
      end

      def running?
        Interface.query 'has-session', '-t', session_name
      end

      def run_command command
        case command
        when String
          Lab42::Tmux::Interface.command command
        when Array
          Lab42::Tmux::Interface.command( *command )
        else
          instance_exec( &command )
        end
      end

      def run_registered_commands
        commands.each do | command |
          run_command command
        end
      end

      class << self 
        def instance an_instance=nil
          return @instance unless an_instance
          @instance = an_instance
        end

        def run
          raise Lab42::Tmux::NoSessionDefined, "you need to define a session with `new_session` in your script" unless instance
          instance.run
        end
      end # class <<
    end # class Session
  end # module Tmux
end # module Lab42
