require_relative '../file'

class << File
  def expand_local_path *args, &blk
    raise ArgumentError, 'need a block to determine source location' unless blk
    values = args + Array( blk.() )
    expand_path File.join( '..', values.compact), blk.source_location.first

  end

  def if_readable path, &blk

    return Lab42::File.enumerate_on_file_readable path unless blk

    return unless readable? path
    return blk.() if blk.arity.zero?

    File.open path, &blk
  end

  def if_writable path, &blk

    return Lab42::File.enumerate_on_file_writable path unless blk

    return unless writable? path
    return blk.() if blk.arity.zero?

    File.open path, "a", &blk
  end
end # class << File
# SPDX-License-Identifier: Apache-2.0
