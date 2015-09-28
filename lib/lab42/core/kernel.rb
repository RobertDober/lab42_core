module Kernel
  def require_relative_dir &blk
    raise ArgumentError, 'need a block to determine source location' unless blk
    dir = File.expand_path File.join( '..', blk.(), '*.rb'), blk.source_location.first
    Dir.glob( dir ).each do | file |
      require file
    end
  end
end
include Kernel
