require 'spec_helper'
 
def expanded_path *args
  File.expand_path( File.join( '..', args ), __FILE__ )
end

describe File, :wip do
  context 'expand_local_path' do 
    it 'does not need the leading ".."' do
      expect( File.expand_local_path{ 'a' } ).to eq expanded_path 'a'
    end
    it 'uses File.join implicitly' do
      expect( File.expand_local_path{ %w{a b} } ).to eq expanded_path( 'a', 'b' )
    end
    it 'can use parameters' do
      expect( File.expand_local_path('a', 'b'){} ).to eq expanded_path( 'a', 'b' )
    end
    it 'can use a combination of parameters and a block' do
      expect( File.expand_local_path('a'){ 'b' } ).to eq expanded_path( 'a', 'b' )
      expect( File.expand_local_path('a'){ %w{b} } ).to eq expanded_path( 'a', 'b' )
    end
    it 'needs a block to determine where _local_ is' do
      expect{ File.expand_local_path('a') }.to raise_error ArgumentError, /need a block to determine source location/
    end


  end # context 'expand_local_path'
end # describe File
