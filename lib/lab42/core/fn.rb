require 'lab42/core/fn/basic_object'
require 'lab42/core/fn/array'
require 'lab42/core/fn/enumerable'
require 'lab42/core/fn/enumerator/lazy'

class Object
  def fn
    # There can only be one (per instance)
    @__lab42_core_fn__ ||= Lab42::Core::Fn.new self
  # But caching in frozen objects is not an option
  rescue
    Lab42::Core::Fn.new self
  end

  def fm
    @__lab42_core_fm__ ||= Lab42::Core::Fm.new self
  # But caching in frozen objects is not an option
  rescue
    Lab42::Core::Fn.new self
  end
end # class Object
