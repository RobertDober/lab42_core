require_relative 'hash'
require 'securerandom'

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

class Module

  def lazy_attr sym, &blk
    raise ArgumentError, 'missing initialization block' unless blk
    memo sym, &blk
  end

  def memoize sym
    orig_method = instance_method sym
    ivar_name = Lab42::Memoizer.make_ivar_name sym

    define_method sym do |*args|
      instance_variable_set ivar_name, {} unless instance_variable_defined? ivar_name
      instance_variable_get( ivar_name ).fetch! args do
        # Not cached yet, caching by means of fetch!
        orig_method.bind( self ).( *args )
      end
    end

    define_method "unmemoize_memo_#{sym}" do | *args |
      return instance_variable_set ivar_name, {} if args.empty?
      instance_variable_get( ivar_name ).delete args
    end
  end

  def memo *args, &blk
    define_method *args, &blk
    memoize args.first
  end
end
