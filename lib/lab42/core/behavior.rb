module Lab42
  module Behavior

    def const_lambda a_const
      -> *a, &b do
        a_const
      end
    end

    def sendmsg *args
      ->(*a){ a.first.send(*(args + a.drop( 1 ))) }
    end

  end # module Behavior
end # module Lab42
