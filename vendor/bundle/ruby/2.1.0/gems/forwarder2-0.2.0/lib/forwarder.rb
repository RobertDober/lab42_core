require 'forwardable'
require 'forwarder/params'

module Forwarder
  
  # How forward works:
  # The parameters are analyzied by the Params object by means of the `prepare_forward`
  # method. The `prepare_forward` method makes have use of the Argument object which
  # implements a query API for what the given arguments allow the forwarder to do.
  # And eventually the `forward!` method realises the delegation
  def forward *args, &blk
    params = Forwarder::Params.new self
    params.prepare_forward( *args, &blk )
    params.forward!
  end

  def forward_all *args, &blk
    opts   = args.pop
    args.each do | arg |
      forward( arg, opts, &blk)
    end
  end
end # module Forwarder
