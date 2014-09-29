module Lab42
  module Tmux
    class Session
      module ParameterHelpers
        def session_address
          "-t #{session_name}"
        end
        def window_address
          "-t #{session_name}:#{window_number}"
        end
      end # module ParameterHelpers
      include ParameterHelpers
    end # class Session
  end # module Tmux
end # module Lab42
