require 'b_helper'

describe Lab42::Behavior::ProcBehavior do 
  context "Proc#to_behavior" do 
    let( :subject ){ ->(a){ a.to_s }.to_behavior }

    it "returns a ProcBehavior" do
      expect( subject ).to be_kind_of described_class
    end

    it "still does the right thing when called" do
      expect( subject.( 42 ) ).to eq "42"
    end
    
  end # context "Proc#to_behavior"
end # describe Lab42::Behavior::ProcBehavior
