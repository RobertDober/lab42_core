module Forwarder
  # I am the workerbee defining the methods and stuff
  class Meta

    attr_reader :arguments, :forwardee

    # TODO: Break AOP out of this so that we do not check @ runtime
    def forward
      if arguments.before_with_block?
        forward_with_before_with_block
      elsif arguments.aop?
        forward_with_aop
      else
        forward_without_aop
      end
    end

    def forward_chain
      a = arguments
      sr = symbolic_receiver
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          if a.before_with_block?
            args = Array(a.before.(*args,&blk)) if a.before_with_block?
            blk = args.pop
          elsif a.before?
            args = instance_exec( *args, &a.before )
          end

          tgt = a.target.inject( self ){ |r, sym| sr.( r, sym ) }
          tgt.send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) ).tap do | result |
              break a.after.( result ) if a.after?
            end
            #.send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) ) 
        end
      end
    end

    def forward_object
      a = arguments
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          args = instance_exec( *args, &a.before ) if a.before?

          a.object_target( self )
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) ).tap do | result |
              break instance_exec( result, &a.after ) if a.after?
            end
        end
      end
      
    end

    private

    def forward_with_aop
      a = arguments
      sr = symbolic_receiver
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          args = instance_exec( *args, &a.before ) if a.before?
          sr
            .( self, a.target )
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) ).tap do | result |
              break instance_exec( result, &a.after ) if a.after?
            end
        end
      end
    end

    def forward_without_aop
      a = arguments
      sr = symbolic_receiver
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          sr
            .( self, a.target )
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) )
        end
      end
    end

    def forward_with_before_with_block
      a = arguments
      sr = symbolic_receiver
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          args = Array(a.before.(*args, &blk))
          new_blk = args.pop

          sr
            .( self, a.target )
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( new_blk ) ).tap do | result |
              break instance_exec( result, &a.after ) if a.after?
            end
        end
      end
      
    end

    def initialize forwardee, arguments
      @forwardee = forwardee
      @arguments = arguments
    end

    def symbolic_receiver
      @__symbolic_receiver__ = ->(rec, sym) do
        case "#{sym}"
        when /\A@/
          rec.instance_variable_get sym
        else
          rec.send sym
        end 
      end
    end

  end # class Meta
end # module Forwarder
