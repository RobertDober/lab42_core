module Lab42
  module Core
    class OpenObject
      module Transformations
        def transform_values beh=nil, &block
          beh ||= block
          inject self.class.new do | acc, oo |
            acc.update oo.keys.first => beh.(oo.values.first) 
          end
        end
      end # module Transformations
    end # class OpenObject
  end # module Core
end # module Lab42
