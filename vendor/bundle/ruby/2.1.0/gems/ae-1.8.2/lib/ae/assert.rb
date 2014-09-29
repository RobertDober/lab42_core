require 'ae/assertor'

module AE

  # The Assert module is simple a conatiner module for the core
  # extension methods: #assert, #expect, etc.
  #
  # This module is included directory into the Object class.
  module Assert

    # Assert a operational relationship.
    #
    #   4.assert == 3
    #
    # If only a single test argument is given then #assert
    # simply validates that it evalutate to true. An optional
    # message argument can be given in this case which will
    # be used instead of the deafult message.
    #
    #   assert(4==3, "not the same thing")
    #
    # In block form, #assert ensures the block evalutes
    # truthfully, i.e. not as nil or false.
    #
    #   assert{ 4==3 }
    #
    # @return [Assertor] Assertion functor.
    def assert(*args, &block)
      Assertor.new(self, :backtrace=>caller).assert(*args, &block)
    end

    # Same as 'object.assert == other'.
    #
    # @return [Assertor] Assertion functor.
    def assert=(cmp)
      Assertor.new(self, :backtrace=>caller).assert == cmp
    end

    # Opposite of assert.
    #
    #   4.refute == 4  #=> Assertion Error
    #
    # @return [Assertor] Assertion functor.
    def refute(*args, &block)
      Assertor.new(self, :backtrace=>caller).not.assert(*args, &block)
    end

    # Same as 'object.refute == other'.
    #
    # @return [Assertor] Assertion functor.
    def refute=(cmp)
      Assertor.new(self, :backtrace=>caller).not.assert == cmp
    end

    # Alias for #refute. Read it as "assert not".
    #
    #   4.assert! == 4
    #
    # NOTE: This method would not be necessary if Ruby would allow
    # +!=+ to be define as a method, or at least +!+ as a unary method.
    # Looks like this is possible in Ruby 1.9, but we will wait until
    # Ruby 1.9 is the norm.
    alias_method :assert!, :refute

    # Directly raise an Assertion failure.
    #
    # @param message [String]
    #   Error message.
    #
    # @param backtrace [String]
    #   Backtrace, used to pass up an error from lower in the stack. 
    #
    # @raise [Assertion]
    #   Assertion error with given `message`.
    def flunk(message=nil, backtrace=nil)
      #Assertor.new(self, :backtrace=>caller).assert(false, message)
      Assertor.assert(false, message, backtrace || caller)
    end

  end

end

# Copyright (c) 2008 Thomas Sawyer
