require 'spec_helper'

describe Lab42::Core::BehaviorArgs do
  context :const_lambda do 
    it "is itself" do
      expect(
        const_lambda( 42 ).()
      ).to eq( 42 )
    end
    it 'is mixed in from Bahvior' do
      expect(
        described_class.const_lambda( 42 ).()
      ).to eq( 42 )
    end
    it "is itself and variadic" do
      expect(
        const_lambda( 42 ).(1){}
      ).to eq( 42 )
    end
  end # context :const_lambda


end # describe Lab42::Core::BehaviorArgs
