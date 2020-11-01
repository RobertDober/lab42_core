class Lab42::Core::RecordImplementation


  private
  def initialize(**kwds)
    self.class.__check_args_!(kwds.keys)
    __initialize_(kwds, self.class.__defaults_)
  end

  def __initialize_(kwds, defaults)
    defaults.merge(kwds).each do |key, val|
      instance_variable_set "@#{key}", val
    end
  end
  
end
