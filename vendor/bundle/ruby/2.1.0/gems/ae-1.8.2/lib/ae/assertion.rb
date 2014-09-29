require 'ae/core_ext'

module AE

  # The Assertion class is simply a subclass of Exception that is used
  # by AE as the default error raised when an assertion fails.
  #
  #   "The reserve of modern assertions is sometimes pushed to extremes,
  #    in which the fear of being contradicted leads the writer to strip
  #    himself of almost all sense and meaning."
  #                              -- Sir Winston Churchill (1874 - 1965)
  #
  #
  class Assertion < Exception

    # @deprecated
    #   This will be removed in favor of `AE::Assertor.counts`.
    def self.counts
      AE::Assertor.counts
    end

    # New assertion (failure).
    #
    # @param message [String] the failure message
    # @param options [Hash] options such as :backtrace
    #
    def initialize(message=nil, options={})
      super(message)
      backtrace = options[:backtrace]
      set_backtrace(backtrace) if backtrace
      set_assertion(true)
    end

    # Technically any object that affirmatively responds to #assertion?
    # can be taken to be an Assertion. This makes it easier for various 
    # libraries to work together without having to depend upon a common
    # Assertion base class.
    def assertion?
      true
    end

    # Parents error message prefixed with "(assertion)".
    #
    # @return [String] error message
    def to_s
      '(assertion) ' + super
    end

  end

end

# Set top-level Assertion to AE::Assertion if not already present.
Assertion = AE::Assertion unless defined?(Assertion)
