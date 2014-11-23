require 'spec_helper'

describe Hash do

  context '#with_present' do 

    context "empty yields empty" do
      it "for no args" do
        expect( {}.with_present(:a){42} ).to be_nil
      end
    end

    context "non empty" do 
      subject do
        { a: 42, b: 43, 42 => :a }
      end
      it "executes the block for present keys" do
        expect( subject.with_present(:a){|v| v.to_s } ).to eq '42'
      end
      it "does not execute the block for absent keys" do
        expect{ subject.with_present(:c){raise RuntimeError} }.not_to raise_error
      end
      it "returns nil in that case" do
        expect( subject.with_present(:c){} ).to be_nil
      end
      it "or whatever we passed in as the default" do
        expect( subject.with_present(:c, default: 44){} ).to eq 44
      end
      it 'passes in the hash as second parameter' do
        expect( subject.with_present(:a){|_,h| h} ).to eq subject
      end
    end # context "non empty"
  end # context '#with_present'
end
