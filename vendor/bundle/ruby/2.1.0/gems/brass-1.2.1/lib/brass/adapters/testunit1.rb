module Test #:nodoc:
  module Unit #:nodoc:
    class TestCase #:nodoc:
      # Runs the individual test method represented by this
      # instance of the fixture, collecting statistics, failures
      # and errors in result.
      def run(result)
        yield(STARTED, name)
        @_result = result
        begin
          setup
          __send__(@method_name)
        rescue AssertionFailedError => e
          add_failure(e.message, e.backtrace)
        rescue Exception => e
          if e.respond_to?(:assertion?) && e.assertion?
            add_failure(e.message, e.backtrace)
          else
            raise if PASSTHROUGH_EXCEPTIONS.include? $!.class
            add_error($!)
          end
        ensure
          begin
            teardown
          rescue AssertionFailedError => e
            add_failure(e.message, e.backtrace)
          rescue Exception => e
            if e.respond_to?(:assertion?) && e.assertion?
              add_failure(e.message, e.backtrace)
            else
              raise if PASSTHROUGH_EXCEPTIONS.include? $!.class
              add_error($!)
            end
          end
        end
        result.add_run
        yield(FINISHED, name)
      end 
    end
  end
end

