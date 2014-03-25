require 'spec_helper'
require 'lab42/core/dir'

describe Dir do 
  context "#files" do
    before do
      stub_dir_with_content "hello", "a", "b/c", "b/"
    end

    let :expected do
      [["a", File.join(ENV["PWD"], "a")], ["b/c", File.join(ENV["PWD"],"b/c")]]
    end
    it "implements stub_dir_with_content" do
      Dir.files( "hello" ).to_a.sort.should eq(expected)
    end
    it "takes a block" do
      x = []
      Dir.files( "hello" ){ |fn,pn| x << [fn, pn] }
      x.should eq( expected )
    end
  end
end # describe Dir
