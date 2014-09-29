module Test #:nodoc:
  module Unit #:nodoc:

    module BrassAssertionHandler
      class << self
        def included(base)
          base.exception_handler(:handle_brass_assertion_failed_error)
        end
      end

      private
      def handle_brass_assertion_failed_error(exception)
        return false unless exception.assertion?
        problem_occurred
        #parameters = exception.parameters    # TODO: assertion parameters
        add_brass_failure exception.message, exception.backtrace,
                    #:expected => exception.expected,
                    #:actual => exception.actual,
                    #:inspected_expected => exception.inspected_expected,
                    #:inspected_actual => exception.inspected_actual,
                    :user_message => exception.message #exception.user_message
        true
      end

      def add_brass_failure(message, backtrace, options={})
        failure = Failure.new(name, filter_backtrace(backtrace), message, options)
        current_result.add_failure(failure)
      end
    end

    class TestCase #:nodoc:
      include BrassAssertionHandler
    end
  end
end

