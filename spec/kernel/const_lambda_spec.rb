require 'spec_helper'

describe Kernel do
  context :const_lambda do 
    it "is itself" do
      expect(
        const_lambda( 42 ).()
      ).to eq( 42 )
    end
    it "is itself and variadic" do
      expect(
        const_lambda( 42 ).(1){}
      ).to eq( 42 )
    end
  end # context :const_lambda


end # describe Kernel
