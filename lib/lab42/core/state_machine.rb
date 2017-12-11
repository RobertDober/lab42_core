module Lab42::Core::StateMachine
  require_relative 'state_machine/class_methods'
  require_relative 'state_machine/transition'
  require_relative 'state_machine/tools'
  T = Lab42::Core::StateMachine::Tools

  attr_reader :current_state, :object

  def self.included into
    into.extend ClassMethods
  end

  def run input

    input.each_with_index do |line, idx|
      match = __handlers__[current_state].find_with_value{ |t, h| t.match line, idx, h } 
      next unless match
      __run_handler__ match
      @current_state = match.state
    end
    __after_last__

    object
  end

  private

  def initialize start_state, initial_value
    @current_state = start_state
    @object        = initial_value
  end

  def __after_last__
    handler  = __handlers__[T.end_state_id].first
    instance_exec(&handler) if handler
  end

  def __run_handler__ match
    case match.handler
    when Proc
      instance_exec(match, &match.handler)
    end
  end

  def __handlers__
    @__handlers__ ||= self.class.send :__handlers__
  end

end
