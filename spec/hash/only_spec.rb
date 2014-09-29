require 'spec_helper'

describe Hash do

  context "empty yields empty" do
    it "for no args" do
      expect( {}.only ).to be_empty
    end
    it "for some args" do
      expect( {}.only :a, 42 ).to be_empty
    end
    it "returns a different object" do
      sub = {}
      clone = sub.only
      sub.merge! a: 42
      expect( sub ).not_to be_empty
      expect( clone ).to be_empty
    end
  end

  context "non empty" do 
    subject do
      { a: 42, b: 43, 42 => :a }
    end
    it "returns an empty subset" do
      expect( subject.only :c ).to be_empty
    end
    it "returns a non empty subset" do
      expect( subject.only :a, 42 ).to eq( :a => 42, 42 => :a )
    end
    it "ignores non existing keys" do
      expect( subject.only :a, 42, 43 ).to eq( :a => 42, 42 => :a )
    end
    it "leaves receiver untouched" do
      clone = subject.only :a, 42, 43 
      subject.clear
      expect( subject ).to be_empty
      expect( clone ).to eq( :a => 42, 42 => :a )
    end
  end # context "non empty"
end
