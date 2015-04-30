require_relative 'hash'
class Module

  def lazy_attr sym, &blk
    raise ArgumentError, 'missing initialization block' unless blk
    define_method sym do
      ivar_name = "@__#{sym}__" 
      return instance_variable_get( ivar_name ) if instance_variable_defined? ivar_name
      instance_variable_set ivar_name, instance_eval( &blk )
    end
  end

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

  def memo *args, &blk
    define_method *args, &blk
    memoize args.first
  end
end
