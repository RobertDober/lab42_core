require 'spec_helper'

RSpec.describe Hash do
  context "#reject_values" do 
    context "is nilpotent" do
      it "on empty hashes" do
        expect( {}.reject_values :odd? ).to be_empty
      end
      it "on values that do not match" do
        expect( {a: 1}.reject_values :even? ).to eq a: 1
      end
    end
    it "but removes matching pairs by value" do
      expect( {a: 1, b: 2}.reject_values :odd? ).to eq b: 2
    end
  end # context "#reject_values"
end
