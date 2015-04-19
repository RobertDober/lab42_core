
module Lab42
  Receiver = BasicObject.new
end # module Lab42

def _realize_args_ para, args
  args.map{ |arg| Proc === arg ? arg.(para) :arg }
end

def _transform_for_f_ args
  args.map do | arg |
    case arg
    when Array
      f *arg
    else
      arg
    end
  end
end

def f *args
  args = _transform_for_f_ args
  # At this level we need to see if there is a Lab42::Receiver
  if Symbol === args.first
    -> r do
      r.send *_realize_args_( r, args )
    end
  else
    -> *r do
      args.first.send *_realize_args_( r.first, args.drop(1) )
    end
  end
end
