module Lab42::Core::StateMachine::Tools extend self


  def begin_state_id
    @__begin_state_id__ ||= "BEGIN_#{SecureRandom.hex}"
  end

  def end_state_id
    @__end_state_id__ ||= "END_#{SecureRandom.hex}"
  end

  def define_handler handler, handler_block
    raise ArgumentError, "cannot provide handler and block" if
      handler_block && !handler.empty?
    raise ArgumentError, "must not provide more than one handler" if
      handler.size > 1

    make_handler( handler.first || handler_block )
  end


  private

  def make_handler handler
    case handler
    when Symbol
      -> *args do
        send(handler, *args)
      end
    when Proc
      handler
    end
  end
  
end
