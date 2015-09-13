require 'spec_helper'
require 'lab42/core/open_object'

describe OpenObject do
  subject do
    described_class.new a: 42, b: 43
  end

  context 'Relationship with Hash' do
    it 'can be one' do
      expect( subject.to_hash ).to eq(a: 42, b: 43 )
    end
    it 'does not expose its data' do
      h = subject.to_hash
      h[:a] = 44
      expect( subject.a ).to eq(42)
      expect( subject.to_hash[:a] ).to eq(42)
    end

    it 'can be constructed from a Hash' do
      expect( {a: 42, b: 43}.to_open_object ).to eq( subject )
    end
  end # context 'Relationship with Hash'

  context 'Hashy behavior' do 
    it 'accesses with []' do
      expect( subject[:a] ).to eq( 42 )
    end
    it 'has the same size semantics' do
      expect( subject.size ).to eq( 2 )
    end
    it 'cannot assign though' do
      expect( ->{ subject[:a]=45} ).to raise_error( NoMethodError )
    end
    it "no it really cannot" do
      expect{ subject.a = 45 }.to raise_error( NoMethodError )
    end
    
  end # context 'Hashy behavior'
end 
