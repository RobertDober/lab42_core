def stub_dir_with_content spec, *content
  dirs, files = content.partition{ |ele| %r{/\z} === ele }

  dirs = dirs.map{ |f| f.sub %r{/\z}, "" }
  File.stub( :directory? ){ |f| dirs.include? f.sub( "#{Dir.pwd}/", "") }

  content = content.map{ |f| f.sub %r{/\z}, "" }

  Dir.stub(:glob){ |glob|
    if glob == spec
      content
    else
      []
    end
  }
end
