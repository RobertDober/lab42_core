class ::Module

  def memoize name, by: ->(n){n}
    im = instance_method name
    cache = {}
    mcache = {}
    # Replace method by the memoized version
    #
    remove_method name
    define_method name do |*args, &blk|
      cache[object_id] ||= {}
      mcache[object_id] ||= im.bind self
      key = by.(*args,&blk)

      return cache[object_id][key] if cache[object_id].has_key? key
      rval = mcache[object_id].(*args, &blk)
      cache[object_id][key] = rval
    end
    wm = instance_method name
    # Create a one time wrapper for cache initialization
    remove_method name
    wrapper = ->(*args,&blk) do
      cache[object_id] = {}
      class << self; self end.module_eval do
        define_method name, wm
      end
      result = wm.bind(self).(*args, &blk)
      # reinstall the wrapper
      class << self; self end.module_eval do
        define_method( name, &wrapper )
      end
      result
    end
    define_method( name, &wrapper )
  end

end
