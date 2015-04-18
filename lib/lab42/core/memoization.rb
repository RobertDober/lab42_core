require_relative 'hash'
class Module
  def memoize sym
    orig_method = instance_method sym
    define_method sym do |*args|
      ivar_name = "@__#{sym}__" 
      instance_variable_set ivar_name, {} unless instance_variable_defined? ivar_name
      instance_variable_get( ivar_name ).fetch! args do
        # Not cached yet!!!
        orig_method.bind( self ).( *args )
      end
    end
  end
end
