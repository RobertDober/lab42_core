require 'spec_helper'
require 'lab42/core/fn'

describe Object do
  
  let(:ary){[*range]}
  let(:enum){range.to_enum}
  let(:lazy){range.lazy}
  let(:range){0..9}
  let(:expected){[*1..10]}
  let(:sum){45}

  def expect_result for_exp: required
    expect( for_exp ).to eq( expected )
  end
  context :map do
    it "for Enumerable" do
      expect_result for_exp: enum.map( :succ )
    end
    it "for Array" do
      expect_result for_exp: ary.map( :succ )
    end
    it "for Enumerator::Lazy" do
      expect_result for_exp: lazy.map( :succ ).to_a
    end

  end # context :map

  context :inject do
    
    it "for Enumerable" do
      expect( enum.reduce Fixnum.fm.+ ).to eq( sum )
      expect( enum.reduce 0, Fixnum.fm.+ ).to eq( sum )
      expect( enum.inject 0, Fixnum.fm.+ ).to eq( sum )
    end

    it "for Array" do
      expect( ary.reduce Fixnum.fm.+ ).to eq( sum )
      expect( ary.reduce 0, Fixnum.fm.+ ).to eq( sum )
      expect( ary.inject 0, Fixnum.fm.+ ).to eq( sum )
    end

  end


end # describe Object

