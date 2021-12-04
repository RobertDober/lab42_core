require 'spec_helper'

describe Dir do

  context ".rel_files" do
    before do
      stub_dir_with_content "hello", "a", "b/c", "b/"
    end
    let :expected do
      %w{ a b/c }
    end
    it "implements stub_dir_with_content" do
      expect( Dir.rel_files( "hello" ).to_a.sort ).to eq expected
    end
    it "takes a block" do
      x = []
      Dir.rel_files( "hello" ){ |fn| x << fn }
      expect( x ).to eq( expected )
    end

    context 'Enumerator' do 
      let( :files_enum ){ Dir.rel_files "hello" }
      it 'behaves like an Enumerator' do
        expect( files_enum.next ).to eq "a"
        expect( files_enum.next ).to eq "b/c"
        expect{ files_enum.next }.to raise_error StopIteration
      end
    end # context 'Enumerator'
  end

  context '.rel_files with an Array' do
    before do
      stub_dir_with_content "hello/world", "b/c"
    end
    let :expected do
      %w{b/c}
    end
    it "implements stub_dir_with_content (applying File.join to first arg if is an ary)" do
      expect( Dir.rel_files( %w{hello world} ).to_a.sort ).to eq expected
    end
  end # context '.rel_files with an Array'
end
# SPDX-License-Identifier: Apache-2.0
