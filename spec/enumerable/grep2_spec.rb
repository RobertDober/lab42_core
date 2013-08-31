require 'spec_helper'

describe Enumerable do
  context "#grep2" do 
    context "partitions" do 
      it "an empty array" do
        x, y = [].grep2 %r{.}
        expect( x ).to be_empty
        expect( y ).to be_empty
      end

      it "an array into two non empty parts" do
        x, y = %w{a b c d e}.grep2 %r{[ae]}
        expect( x ).to eq( %w{a e} )
        expect( y ).to eq( %w{b c d} )
      end

      it "an array into an empty else part" do
        x, y = %w{a b c d e}.grep2 %r{.}
        expect( x ).to eq( %w{a b c d e} )
        expect( y ).to be_empty
      end
      it "an array into an empty if part" do
        x, y = %w{a b c d e}.grep2 %r{\d}
        expect( y ).to eq( %w{a b c d e} )
        expect( x ).to be_empty
      end
    end # context "partitions"
  end # context "#grep2"
end # describe Enumerable
