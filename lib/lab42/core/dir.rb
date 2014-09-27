class << Dir
  def files glob_para, &blk
    return enum_for(:__files__, glob_para) unless blk
    __files__ glob_para, &blk
  end

  private

  def __files__ glob_para, &blk
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
