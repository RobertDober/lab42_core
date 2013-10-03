require 'spec_helper'
require 'lab42/core/fn'

describe Object do
  let(:source){8..11}
  let(:expected){[9,1,2,3]}

  it "can use fn" do
    expect( Integer.fn.cksum.(12) ).to eq( 4 )
  end

  it "can be used as a block for arrays" do
    expect( [*source].map Integer.fn.cksum ).to eq( [9,1,2,3] )
  end

  it "can be used as a block for enumerables" do
    expect( source.map Integer.fn.cksum ).to eq( [9,1,2,3] )
  end

  it "can be used for enumerators" do
    expect( source.to_enum.map( Integer.fn.cksum ).to_a ).to eq( [9,1,2,3] )
  end

  it "can be used for lazy enumerators" do
    expect( source.lazy.map( Integer.fn.cksum ).to_a ).to eq( [9,1,2,3] )
  end
end # describe Object
