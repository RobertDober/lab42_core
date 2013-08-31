
def stub_directories *dirs
  dirs.each{ |dir| stub_directory dir }
end

def stub_directory dir
  File.should_receive(:directory?).with( dir ).and_return true
end

def stub_file_does_not_exist fn
  File.should_receive(:read).with(fn){ raise Errno::ENOENT, "No such file or directory - #{fn}" }
end

def stub_read_file fn, with_content: ""
  File.should_receive(:read).with(fn).and_return with_content
end
