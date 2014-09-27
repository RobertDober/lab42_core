class << Dir
  def files glob_para, &blk
    __files__ glob_para, &blk
  end

  private

  def __files__ glob_para, &blk
    here = pwd
    if blk
      glob( glob_para ).each do | f |
        next if File.directory? f
        blk.( [ f, File.expand_path(File.join( here, f )) ] )
      end
    else
      Enumerator.new do |y|
        glob( glob_para ).each do | f |
          next if File.directory? f
          y.yield [ f, File.expand_path(File.join( here, f )) ]
        end
      end
    end
  end
end
