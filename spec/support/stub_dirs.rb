def stub_dir_with_content spec, *content
  dirs, files = content.partition{ |ele| %r{/\z} === ele }

  dirs = dirs.map{ |f| f.sub %r{/\z}, "" }
  allow( File ).to receive( :directory? ){ |f| dirs.include? f.sub( "#{Dir.pwd}/", "") }

  content = content.map{ |f| f.sub %r{/\z}, "" }

  allow( Dir ).to receive(:glob){ |glob|
    if glob == spec
      content
    end
  }
end
