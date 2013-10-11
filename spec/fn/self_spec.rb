require 'spec_helper'
require 'lab42/core/fn'

describe Object do
  it "has a constant proc to return itself" do
    o = Object.new
    expect( o.fn.self.() ).to eq( o )
  end
  it "has a constant proc to return itself and is variadic" do
    o = Object.new
    expect( o.fn.self.(:a, :b){} ).to eq( o )
  end
  
  it "so that we can map" do
    expect(
       (1..2).map( 42.fn.self )
    ).to eq( [42, 42] )
  end

  it "or filter" do
    expect(
      (1..2).select( false.fn.self )
    ).to be_empty
  end
end # describe Object
