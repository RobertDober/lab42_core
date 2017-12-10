module Lab42::Core::StateMachine
  require_relative 'state_machine/class_methods'
  require_relative 'state_machine/transition'

  attr_reader :current_state, :object

  def self.included into
    into.extend ClassMethods
  end

  def run input
    input.each_with_index do |line, idx|
      match = __handlers__[current_state].find_with_value{ |t, h| t.match line, idx, h } 
      next unless match
      run_handler match
      @current_state = match.state
    end
    object
  end

  private

  def initialize start_state, initial_value
    @current_state = start_state
    @object        = initial_value
  end

  def get_next_transition state, line, idx
    transitions(state)
      .find_value{ |t| t.match line, idx } || default_transtions(state) or
          raise StopIteration,
            "no transition found in state #{state.inspect} on input line #{idx.succ}:\t#{line}"
  end

  def initial_object
    {} 
  end

  def run_handler match
    case match.handler
    when Proc
      instance_exec(match, &match.handler)
    when UnboundMethod
      match.handler.bind(self).(match)
    end
  end

  def __handlers__
    @__handlers__ ||= self.class.send :__handlers__
  end

end
