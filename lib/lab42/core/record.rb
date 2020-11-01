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
      
      define_singleton_method :__check_args_! do |provided|
        missing = required - provided
        forbidden = provided - required - defaulted.keys
        return if missing.empty? && forbidden.empty?
        raise ArgumentError, __make_message_(missing, forbidden)
      end

      define_singleton_method :__defaults_ do
        # TODO: Check for lambdas and/or types
        defaulted
      end

      private
      define_singleton_method :__make_message_ do |missing, forbidden|
        [
          (missing.empty? ? nil : "missing required keys: #{missing.inspect}"),
          (forbidden.empty? ? nil : "forbidden args: #{forbidden.inspect}")
        ].compact
          .join("\n")
      end

    end
  end
end
