require 'spec_helper'

describe Enumerable, :wip do
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

      it "works for enumerables" do
        x, y = ('a'..'e').grep2 %r{[ae]}
        expect( x ).to eq( %w{a e} )
        expect( y ).to eq( %w{b c d} )
      end

      context Enumerator::Lazy do 
        subject do
          ('a'..'e').to_enum.lazy
        end
        before do
          @x, @y = subject.grep2 %r{[ae]}
          
        end

        it 'partitions into two enumerators' do
          expect( @x ).to be_kind_of Enumerator::Lazy
          expect( @y ).to be_kind_of Enumerator::Lazy
        end

        it 'which yield the partitioned values' do
          expect( @x.to_a ).to eq %w{a e}
          expect( @y.to_a ).to eq %w{b c d}
        end
        
      end # context Enumerator

    end # context "partitions"
  end # context "#grep2"
end # describe Enumerable
