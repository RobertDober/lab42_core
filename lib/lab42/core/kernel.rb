module Kernel
  def sendmsg *args
    ->(*a){ a.first.send(*(args + a.drop( 1 ))) }
  end
end # module Kernel
