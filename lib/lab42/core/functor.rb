require_relative 'functor/factory'
require_relative 'functor/is_a_proc'
module Lab42
  class Functor
    attr_reader :args, :block, :callable, :message
    include IsAProc

    def call *a, &b
      if callable
        arguments = fill_args( a )
        callable.( *arguments, &(block || b) )
      else
        arguments = fill_args( a.drop 1 )
        a.first.send( message, *arguments, &(block || b) )
      end
    end

    private
    # if we have at least one argument we bind the message to it
    def initialize message, *args, &block
      @block    = block
      @message  = message
      @callable = __callable? message, args
      @args     = args.drop 1
    end

    def fill_args it_args
      arguments = args.dup
      args.each_with_index do | arg, idx |
        it_args = fill_argument arguments, arg, idx, it_args
      end
      arguments
    end

    def fill_argument in_arguments, arg_or_placeholder, at_index, from_it_arguments, inital, needed
      return from_it_arguments unless is_placeholder? arg_or_placeholder
      in_arguments[at_index] = from_it_arguments.fetch(0){ raise ArgumentError, "wrong number of arguments (#{initial} for #{needed}..) }
      from_it_arguments.drop 1
    end

    def is_placeholder? arg
      [Lab42::Functor::Factory, Lab42::MethodFunctor::Factory].include? arg
    end

    def __callable? message, args 
      !args.empty? && args.first.method( message )
    rescue
      false
    end
  end # class Functor

  class MethodFunctor < Functor
    def call *a, &b
      a.first.send( message, *(args + a.drop(1)), &(block || b) )
    end
    private
    def initialize message, *args, &block
      @block   = block
      @message = message
      @args    = args
    end
  end # class MethodFunctor
end
