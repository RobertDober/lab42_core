require 'spec_helper'

describe OpenObject do
  subject do
    described_class.new a: 42, b: 43
  end

  context 'access' do 
    it { expect( subject.a ).to eq( 42 ) }
  end # context 'access'

  context 'immutable' do
    it "creates new object for merge" do
      clone = subject.update( a: 44 )
      expect( subject.a ).to eq(42)
      expect( clone.a ).to eq(44)
    end

    it "merges all data" do
      expect( subject.merge( a: 44 ).b ).to eq( 43 )
    end

    it 'merges and updates all the same' do
      expect( subject.method :merge ).to eq( subject.method :update )
    end
  end

end # describe Lab42::Core::OpenObject
