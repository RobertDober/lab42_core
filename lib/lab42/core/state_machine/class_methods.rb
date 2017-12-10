module Lab42::Core::StateMachine::ClassMethods

  require_relative 'transition'
  require_relative 'tools'
  T = Lab42::Core::StateMachine::Tools

  def add_transition from_state, trigger_expr, *handler, to: from_state, &handler_block
    handler = T.define_handler(handler, handler_block)
    trigger = Lab42::Core::StateMachine::Transition
      .new(to, trigger_expr) 
    __register__ from_state, [trigger, handler]
  end

  
  private

  def __register__ state, actions
    __handlers__[state] << actions
  end

  def __handlers__
    @__handlers__ ||= Hash.new{ |h, k| h[k] = [] }
  end
end
