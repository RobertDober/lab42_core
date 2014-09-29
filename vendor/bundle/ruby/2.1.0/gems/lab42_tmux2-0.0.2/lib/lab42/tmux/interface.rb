module Lab42
  module Tmux
    module Interface extend self
      def command *args
        puts( args.join(' ') ) if $DEBUG
        %x{ tmux #{ args.join ' ' } }
      end
      def query *args
        puts( args.join(' ') ) if $DEBUG
        system "tmux #{ args.join ' ' }"
      end
    end # module Interface
  end # module Tmux
end # module Lab42
