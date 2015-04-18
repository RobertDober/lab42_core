require 'spec_helper'

describe Hash do 

  context '#fetch! with present keys -- no side effects' do 
    let( :hash ){ {a: 43} }
    it 'gets the value, default value ignored' do
      expect( hash.fetch! :a, 42 ).to eq 43
      expect( hash ).to eq a: 43
    end
    it 'gets the value, default block ignored' do
      expect( hash.fetch!( :a ){ 41 } ).to eq 43
      expect( hash ).to eq a: 43
    end
  end # context '#fetch! with present keys'

  context '#fetch! result without present keys -- side effects' do 
    let( :hash ){ {} }
    it 'raises an IndexError' do
      expect{ hash.fetch! :a }.to raise_error IndexError
      expect( hash ).to be_empty
    end
    it 'gets the default value' do
      expect( hash.fetch! :a, 42 ).to eq 42
      expect( hash ).to eq a: 42
    end
    it "gets the default block's value" do
      expect( hash.fetch!( :a ){ 41 } ).to eq 41
      expect( hash ).to eq a: 41
    end
  end # context '#fetch! result without present keys'

end # describe Hash
