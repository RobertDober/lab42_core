module Kernel

  # TODO: Should `#expect` method be part of standard?

  # Executate a block asserting that a type of error will be raised.
  #
  # Presently this is not part of brass by default, as whether it should
  # be is under debate. So this file must be required separately:
  #
  #   require 'brass/expect'
  #
  def expect(error_class) #:yield:
    begin
      yield
      assert(false, error_class, "#{error_class} expected but none thrown")
    rescue error_class
      assert(true)
    rescue Exception => err
      assert(false, error_class, "#{error_class} expected but #{err.class} was thrown")
    end
  end

end

