require 'spec_helper'

describe Dir do

  def pair local_path
    [ local_path, File.join(ENV["PWD"], local_path) ]
  end

  context ".files" do
    before do
      stub_dir_with_content "hello", "a", "b/c", "b/"
    end
    let :expected do
      [ pair( "a" ), pair( "b/c" ) ]
    end
    it "implements stub_dir_with_content" do
      expect( Dir.files( "hello" ).to_a.sort ).to eq expected
    end
    it "takes a block" do
      x = []
      Dir.files( "hello" ){ |fn,pn| x << [fn, pn] }
      expect( x ).to eq( expected )
    end

    context 'Enumerator' do 
      let( :files_enum ){ Dir.files "hello" }
      it 'behaves like an Enumerator' do
        expect( files_enum.next ).to eq pair( "a" )
        expect( files_enum.next ).to eq pair( "b/c" )
        expect{ files_enum.next }.to raise_error StopIteration
      end
    end # context 'Enumerator'
  end

  context '.files with an Array' do
    before do
      stub_dir_with_content "hello/world", "b/c"
    end
    let :expected do
      [ pair( "b/c" ) ]
    end
    it "implements stub_dir_with_content (applying File.join to first arg if is an ary)" do
      expect( Dir.files( %w{hello world} ).to_a.sort ).to eq expected
    end
  end # context '.files with an Array'
end
# SPDX-License-Identifier: Apache-2.0
