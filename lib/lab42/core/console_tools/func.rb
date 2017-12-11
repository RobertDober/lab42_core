
module Lab42
  Receiver = BasicObject.new
end # module Lab42

def _realize_args_ para, args
  args.map{ |arg| Proc === arg ? arg.(para) :arg }
end


def f *args
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
