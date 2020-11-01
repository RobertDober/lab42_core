require_relative "./record/implementation"
module Kernel
  def Record(*required, **defaulted)
    Class.new Lab42::Core::RecordImplementation do
      required.each do |req|
        attr_accessor req
      end
      defaulted.keys.each do |req|
        attr_accessor req
      end
      
      define_singleton_method :__check_required_! do |provided|
        missing = required - provided
        return if missing.empty?
        raise Lab42::Core::RecordImplementation::RequiredKeysMissing,
          "missing required keys: #{missing.inspect}"
      end

      define_singleton_method :__defaults_ do
        # TODO: Check for lambdas and/or types
        defaulted
      end

    end
  end
end
