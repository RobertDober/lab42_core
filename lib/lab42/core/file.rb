class << File
  def expand_local_path *args, &blk
    raise ArgumentError, 'need a block to determine source location' unless blk
    values = args + Array( blk.() )
    expand_path File.join( '..', values.compact), blk.source_location.first
    
  end
end # class <<
