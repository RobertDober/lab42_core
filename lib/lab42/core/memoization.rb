require_relative 'hash'

module Lab42::Memoizer extend self
  def make_ivar_name from_sym
    [
      '@',
    from_sym
      .to_s
      .sub('!', 'bang')
      .sub('?', '_p'),
      Time.now.nsec.to_s(36),
      SecureRandom.uuid.gsub('-','')
    ].join("_")
  end
  
end # module Lab42::Memoizer

module Lab42::Unmemoizer
  def unmemoize_memo method_name, *args
    ivar_name = @__lAB_42__memoization_cache_4ysr5zu[ method_name ]
    raise ArgumentError, "not memoized, method #{method_name}" unless ivar_name
    return unless instance_variable_defined? ivar_name
    return instance_variable_set ivar_name, {} if args.empty?
    instance_variable_get( ivar_name ).delete args
  end
end # module Lab42::Unmemoizer

class Module

  include Lab42::Unmemoizer

  def lazy_attr sym, &blk
    raise ArgumentError, 'missing initialization block' unless blk
    memo sym, &blk
  end

  def memoize sym
    include Lab42::Unmemoizer
    orig_method = instance_method sym
    ivar_name = Lab42::Memoizer.make_ivar_name sym
    cache = @__lAB_42__memoization_cache_4ysr5zu ||= {}
    cache[sym] = ivar_name

    define_method sym do |*args|
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
