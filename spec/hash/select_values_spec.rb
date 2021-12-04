require 'spec_helper'

RSpec.describe Hash do
  context "#select_values" do 
    context "is nilpotent" do
      it "on empty hashes" do
        expect( {}.select_values :odd? ).to be_empty
      end
      it "on values that do not match" do
        expect( {a: 1}.select_values :odd? ).to eq a: 1
      end
    end
    it "but removes matching pairs by value" do
      expect( {a: 1, b: 2}.select_values :odd? ).to eq a: 1
    end
  end # context "#reject_values"
end
# SPDX-License-Identifier: Apache-2.0
