module Lab42
  module Memoization extend self
    def hash_args args
    end 
  end # module Memoization
end # module Lab42
class Module
  def memoize sym
    orig_method = instance_method sym
    define_method sym do |*args|
      ivar_name = "@__#{sym}__" 
      instance_variable_set ivar_name, {} unless instance_variable_defined? ivar_name
      instance_variable_get( ivar_name ).tap do | cache |
        return cache.fetch( args ) do
          # Not cached yet!!!
          cache[ args ] = orig_method.bind( self ).( *args )
        end
      end
    end
  end
end
