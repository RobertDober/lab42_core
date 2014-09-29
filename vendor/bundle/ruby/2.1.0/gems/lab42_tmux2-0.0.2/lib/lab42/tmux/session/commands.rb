require_relative 'parameter_helpers'

module Lab42
  module Tmux
    class Session
      module Commands
        def new_window window_name, &block
          @window_number += 1
          command 'new-window', '-t', session_name, '-n', window_name
          instance_exec( &@after_new_window_hook ) if @after_new_window_hook
          instance_exec( &block ) if block
        end

        def send_keys *keys
          command( 'send-keys', '-t', [session_name, window_number].join(':'), *keys.map(&:inspect), 'C-m' )
        end

        def send_keys_raw *keys
          command( 'send-keys', '-t', [session_name, window_number].join(':'), *keys.map(&:inspect) )
        end

        def wait_for text_or_rgx, alternate_pane_addr=nil, &blk
          require 'timeout'
          pane_addr = alternate_pane_addr || window_address
          text_or_rgx = %r{#{text_or_rgx}}m unless Regexp === text_or_rgx
          conditional_sleep configuration.pre_wait_interval
          Timeout.timeout configuration.wait_timeout do
            really_wait_for text_or_rgx, in_pane: pane_addr, dependent_actions: blk
          end
        rescue Timeout::Error 
        end

        def really_wait_for( match_rgx, in_pane:, dependent_actions: )
          loop do
            text = capture_pane in_pane
            if match_rgx === text
              conditional_sleep configuration.post_wait_interval
              return instance_exec( &dependent_actions )
            end
            sleep configuration.wait_interval
          end
        end

        private 
        def capture_pane pane_addr
          command( 'capture-pane', *(pane_addr.split), '-p' ).tap  do |result  |
            p result if $DEBUG
          end
        end
        def conditional_sleep sleepy_or_falsy
          sleep sleepy_or_falsy if sleepy_or_falsy
        end

      end # module Commands
      include Commands
    end # class Session
  end # module Tmux
end # module Lab42
