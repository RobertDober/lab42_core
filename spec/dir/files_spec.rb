require 'spec_helper'

describe Dir do 
  context "#files" do
    it "implements stub_dir_with_content" do
      stub_dir_with_content "hello", "a", "b/c", "b/"
      Dir.files( "hello" ).to_a.sort.should eq([["a", File.join(ENV["PWD"], "a")], ["b/c", File.join(ENV["PWD"],"b/c")]])
    end
  end
end # describe Dir
