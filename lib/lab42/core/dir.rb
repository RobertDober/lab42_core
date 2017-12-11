require_relative 'meta'
class << Dir
  def abs_files glob_para, *rst, &blk
    glob_para = File.join( *glob_para ) if Array === glob_para
    blk = Lab42::Meta::Behavior.behavior *rst, &blk

    __files__ :last, glob_para, &blk
  end

  def files glob_para, *rst, &blk
    glob_para = File.join( *glob_para ) if Array === glob_para
    blk = Lab42::Meta::Behavior.behavior *rst, &blk

    __files__ :both, glob_para, &blk
  end

  def rel_files glob_para, *rst, &blk
    glob_para = File.join( *glob_para ) if Array === glob_para
    blk = Lab42::Meta::Behavior.behavior *rst, &blk

    __files__ :first, glob_para, &blk
  end

  private

  def __files__ selector, glob_para, &blk
    here = pwd
    if blk
      glob( glob_para ).map do | f |
        next if File.directory? f
        blk.( __select__( selector, f ){ File.expand_path File.join( here, f ) } )
      end.compact
    else
      Enumerator.new do |y|
        glob( glob_para ).each do | f |
          next if File.directory? f
          y.yield __select__( selector, f ){ File.expand_path File.join( here, f ) }
        end
      end
    end
  end

  def __select__ selector, frst_param, &last_param
    case selector
    when :first
      frst_param
    when :last
      last_param.()
    when :both
      [ frst_param, last_param.() ]
    end
  end
end
