require_relative 'behavior/proxy'
 
class Object
  def fn
    Lab42::Behavior::Proxy.new self
  end
end # class Object
