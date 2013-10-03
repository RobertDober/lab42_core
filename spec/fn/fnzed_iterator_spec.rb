require 'spec_helper'
require 'lab42/core/fn'

describe Object do
  
  let(:ary){[*range]}
  let(:enum){range.to_enum}
  let(:lazy){range.lazy}
  let(:range){0..9}
  let(:expected){[*1..10]}

  def expect_result for_exp: required
    expect( for_exp ).to eq( expected )
  end
  context :map, :wip do
    it "for Enumerable" do
      expect_result for_exp: range.map( :succ )
    end
    it "for Array" do
      expect_result for_exp: ary.map( :succ )
    end
    
  end # context :map

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

