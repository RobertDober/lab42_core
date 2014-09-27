require 'spec_helper'

describe Dir, :wip do
  context "#files" do
    before do
      stub_dir_with_content "hello", "a", "b/c", "b/"
    end

    let :expected do
      [["a", File.join(ENV["PWD"], "a")], ["b/c", File.join(ENV["PWD"],"b/c")]]
    end
    it "implements stub_dir_with_content" do
      expect( Dir.files( "hello" ).to_a.sort ).to eq expected
    end
    it "takes a block" do
      x = []
      Dir.files( "hello" ){ |fn,pn| x << [fn, pn] }
      expect( x ).to eq( expected )
    end
  end
end # describe Dir
