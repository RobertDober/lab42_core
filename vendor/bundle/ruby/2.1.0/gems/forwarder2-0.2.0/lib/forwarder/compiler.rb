require 'forwarder/evaller'
module Forwarder
  # The compiler's responsability is to create a string representation of
  # the delegation method, or to nil if no such string representation exists
  # and delegation has to be done dynamically.
  class Compiler
    attr_reader :arguments

    
    def compile
      # Cannot compile because of intrinsic uncompilable traits of arguments
      return if arguments.must_not_compile?

      # To Hash can always compile
      return compile_to_hash if arguments.to_hash?

      # Cannot compile only because the arguments.args cannot be compiled
      @compiled_args = Evaller.serialize arguments.args
      return unless @compiled_args

      # Can compile :)))
      return compile_to_all if arguments.message.is_a? Array
      compile_one
    end

    private

    def compile_one
      tltion = arguments.translation arguments.message
      "def #{arguments.message} *args, &blk; " +
        "#{self.class.compile_target arguments.target}.#{tltion}( " +
        @compiled_args +
        "*args, &blk ) end"
    end

    def compile_to_all
      arguments.message.map{ |msg|
        "def #{msg} *args, &blk; #{arguments.target}.#{msg}( *args, &blk ) end"
      }.join("\n")
    end

    def compile_to_hash
      target = arguments.to_hash?
      target = target.join(".") if Array === target
      [arguments.message]
        .flatten
        .map do | msg |
          # N.B. that the expression between [] is always a Symbol
          "def #{msg}; #{target}[ #{(arguments.translation||msg).to_sym.inspect} ] end"
        end.join("\n")#.tap do |x| debugger end
    end

    def initialize args
      @arguments = args 
    end
    
    class << self
      def compile_target target
        [ target ].flatten.join( "." )
      end
    end
  end # class Compiler
end # module Forwarder
