module Lab42::Core::StateMachine::Tools extend self


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
      -> match do
        send(handler, match)
      end
    end
  end
  
end
