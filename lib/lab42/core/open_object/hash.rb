require 'lab42/core/open_object/hash'
class ::Hash

  def to_open_object
    Lab42::Core::OpenObject.new **self
  end

  
end # class ::Hash