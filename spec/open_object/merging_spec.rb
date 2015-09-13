require 'spec_helper'
require 'lab42/core/open_object'

describe OpenObject do 
  context ".merging" do 
    context "No args" do 
      it{ expect( described_class.merging ).to be_kind_of described_class }
      it{ expect( described_class.merging.to_hash ).to eq( {} ) }
    end # context "No args"

    context "some args" do 
      let( :a ){ described_class.new a: 42,        c: 44   }
      let( :b ){ described_class.new a: 41, b: 42          }
      let( :c ){                   { a: 40, b: 41, c: 42 } }

      context "all Open Objects again" do 
        it{ expect( described_class.merging a, b ).to be_kind_of described_class }
        it{ expect( described_class.merging a ).to be_kind_of described_class }
        it{ expect( described_class.merging a, b, c: 3 ).to be_kind_of described_class }
      end # context "all Open Objects again"

      context "correct merging" do 
        it{ expect( described_class.merging( a, b ).to_hash ).to eq a: 41, b: 42, c: 44 }
        it{ expect( described_class.merging( a, b, c, a ).to_hash ).to eq a: 42, b: 41, c: 44 }
        it{ expect( described_class.merging( a, b, c, a, c: 0, d: 1 ).to_hash ).to eq a: 42, b: 41, c: 0, d: 1 }
      end # context "correct merging"

    end # context "some args"
  end # context ".merging"
end # describe OpenObject
