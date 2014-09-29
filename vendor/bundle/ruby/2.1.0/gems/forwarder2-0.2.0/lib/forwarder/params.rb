require 'forwarder/arguments'
require 'forwarder/compiler'
require 'forwarder/meta'

module Forwarder
  class Params
    attr_reader :forwardee, :arguments
    def forward!
      compiled = compile_forward
      if compiled
        forwardee.module_eval compiled, __FILE__, __LINE__
      else
        general_delegate
      end
    end

    def prepare_forward *args, &blk
      @arguments = Arguments.new( *args, &blk ) 
    end
    
    private

    def compile_forward
      compiler = Compiler.new arguments
      compiler.compile 
    end

    def initialize forwardee
      @forwardee = forwardee
    end

    def general_delegate
      if arguments.chain?
        Meta.new( forwardee, arguments ).forward_chain
      elsif arguments.custom_target?
        Meta.new( forwardee, arguments ).forward_object
      else
        Meta.new( forwardee, arguments ).forward
      end
    end
  end # class Params
end # module Forwarder
