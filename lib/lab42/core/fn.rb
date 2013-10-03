require 'lab42/core/fn/basic_object'
require 'lab42/core/fn/array'
require 'lab42/core/fn/enumerable'
require 'lab42/core/fn/enumerator/lazy'

class Object
  __lab42_core_fn__ = nil
  define_method :fn do
    __lab42_core_fn__ ||= Lab42::Core::Fn.new self
  end
end # class Object
