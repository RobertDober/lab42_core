require_relative '../errors'

module Lab42
  module Tmux
    class Session
      module Hooks
        def after_new_window &blk
          raise ArgumentError, 'after_new_window needs a block' unless blk
          raise MultipleHook, 'no multiple after_new_window hooks allowed in one session' if @after_new_window_hook

          @after_new_window_hook = blk
          # **This one is **ugly**, for implicit window 0
          instance_exec(&blk)
        end
      end # module Hooks
      include Hooks
    end # class Session
  end # module Tmux
end # module Lab42
