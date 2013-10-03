require 'spec_helper'
require 'lab42/core/fn'

describe Object, :wip do
  it "can use fn" do
    expect( Integer.fn.cksum.(12) ).to eq( 4 )
  end

  it "can be used as a block for arrays" do
    expect( [*8..11].map Integer.fn.cksum ).to eq( [9,1,2,3] )
  end
  it "can be used as a block for enumerables" do
    expect( (8..11).map Integer.fn.cksum ).to eq( [9,1,2,3] )
  end

  it "can be used for enumerators" do
    expect( (8..11).to_enum.map( Integer.fn.cksum ).to_a ).to eq( [9,1,2,3] )
  end
  it "can be used for lazy enumerators" do
    expect( (8..11).lazy.map( Integer.fn.cksum ).to_a ).to eq( [9,1,2,3] )
  end
end # describe Object
