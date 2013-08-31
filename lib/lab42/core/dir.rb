class << Dir
  def files glob_para
    glob( glob_para ).map do |f|
      full = File.join pwd, f
      require 'pry'
      next if File.directory? full
      [f, full]
    end.compact
  end
end
