require_relative 'behavior/proxy'
require_relative 'b'
 
class Object
  def fn
    Lab42::Behavior::Proxy.new self, fm: false
  end
end # class Object

class Module
  def fm
    Lab42::Behavior::Proxy.new self, fm: true
  end
end
