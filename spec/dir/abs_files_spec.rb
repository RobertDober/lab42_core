require 'spec_helper'

describe Dir do

  def abs local_path
    File.join(ENV["PWD"], local_path)
  end

  context ".abs_files" do
    before do
      stub_dir_with_content "hello", "a", "b/c", "b/"
    end
    let :expected do
      [ abs( "a" ), abs( "b/c" ) ]
    end
    it "implements stub_dir_with_content" do
      expect( Dir.abs_files( "hello" ).to_a.sort ).to eq expected
    end
    it "takes a block" do
      x = []
      Dir.abs_files( "hello" ){ |pn| x << pn }
      expect( x ).to eq( expected )
    end

    context 'Enumerator' do 
      let( :files_enum ){ Dir.abs_files "hello" }
      it 'behaves like an Enumerator' do
        expect( files_enum.next ).to eq abs( "a" )
        expect( files_enum.next ).to eq abs( "b/c" )
        expect{ files_enum.next }.to raise_error StopIteration
      end
    end # context 'Enumerator'
  end

  context '.abs_files with an Array' do
    before do
      stub_dir_with_content "hello/world", "b/c"
    end
    let :expected do
      [ abs( "b/c" ) ]
    end
    it "implements stub_dir_with_content (applying File.join to first arg if is an ary)" do
      expect( Dir.abs_files( %w{hello world} ).to_a.sort ).to eq expected
    end
  end # context '.abs_files with an Array'
end
