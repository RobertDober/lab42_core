require_relative 'tmux/config'
require_relative 'tmux/interface'
require_relative 'tmux/session'

module Lab42
  module Tmux

    def config &block
      $config = Config.new
      $config.instance_exec( &block )
    end

    def new_session session_name, &block
      raise ArgumentError, 'No block provided' unless block
      session = Session.new session_name
      session.run &block
    end

    def dry_run!
      require_relative 'tmux/dry_run'
    end
  end # module Tmux
end # module Lab42
