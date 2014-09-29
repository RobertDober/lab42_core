module Lab42
  module Tmux
    # Dry Run Interface
    module Interface extend self
      def command *args
        puts args.join( ' ' )
        if args.first == 'capture-pane'
          capture_pane( *args.drop( 1 ) )
        end
      end
      def query *args
        puts args.join( ' ' )
        args.first != 'has-session'
      end

      private
      def capture_pane *args
        pane_addr = args[1]
        second_capture = (@panes ||= {})[pane_addr]
        if second_capture
          @panes[pane_addr] = false
          'hit'
        else
          @panes[pane_addr] = true
          'miss'
        end
      end
    end # module Interface
  end # module Tmux
end # module Lab42
