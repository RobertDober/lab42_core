class Exception

  # Is the exception an assertion error?
  def assertion?
    @assertion
  end

  # Set the the exception's assertion flag.
  def set_assertion(boolean)
    @assertion = boolean # ? true : false
  end

  # Set message.
  # (not strictly needed here, but can be useful anyway).
  #
  # @todo Does the message have to be a string?
  def set_message(msg)
    @mesg = msg.to_str
  end

  # TODO: Consider assertion parameters for future vresion.
  ##
  #def parameters
  #  @parameters
  #end
  #
  ## Set exception parameters. These are used to store specific information
  ## relavent to a particular exception or assertion. Unlike the message,
  ## which is a String, this is a Hash.
  #def set_parameters(parameters)
  #  @parameters = parameters.to_hash
  #end

end

module Kernel

  # Track assertions counts.
  $ASSERTION_COUNTS ||= Hash.new{ |h,k| h[k] = 0 }

  #
  # Universal assertion method.
  #
  def assert(truth, *raise_arguments)
    $ASSERTION_COUNTS[:total] += 1
    if truth
      $ASSERTION_COUNTS[:pass] += 1
    else
      $ASSERTION_COUNTS[:fail] += 1
      # if fail set assertion=true then just,
      #   fail *raise_arguments
      # but alas ...
      fail! *raise_arguments
    end
  end

  module_function :assert

  #
  # Universal refutation method (opposite of `#assert`).
  #
  def refute(truth, *raise_arguments)
    $ASSERTION_COUNTS[:total] += 1
    if truth
      $ASSERTION_COUNTS[:fail] += 1
      # if fail set assertion=true then just,
      #   fail *raise_arguments
      # but alas ...
      fail! *raise_arguments
    else
      $ASSERTION_COUNTS[:pass] += 1
    end
  end

  module_function :refute

  #
  # Alternate for #fail that also sets assertion flag to +true+.
  #
  def fail!(*raise_arguments)
    backtrace = case raise_arguments.last
                when Array
                  raise_arguments.pop
                else
                  nil
                end

    exception = case raise_arguments.first
                when Exception
                  raise_arguments.shift
                when Class
                  raise ArgumentError unless Exception > raise_arguments.first
                  error_class = raise_arguments.shift
                  error_class.new(*raise_arguments)
                else
                  error_class = $! || RuntimeError
                  error_class.new(*raise_arguments)
                end

    exception.set_backtrace(backtrace) if backtrace
    exception.set_assertion(true)

    fail exception
  end

  module_function :fail!

  private :assert
  private :refute
  private :fail!

end
