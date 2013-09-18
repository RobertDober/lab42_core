class << Dir
  def files glob_para, &blk
    glob( glob_para ).map do |f|
      full = File.join pwd, f
      next if File.directory? full
      [f, full]
    end
      .compact
      .tap do | result |
        result.each(&blk) if blk
      end
  end
end
