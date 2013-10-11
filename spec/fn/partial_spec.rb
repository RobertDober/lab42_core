require 'spec_helper'
require 'lab42/core/fn'

describe Object do 
  
  let(:push_next){Array.fm.push(:next)}

  it "can be applied with 0 additional args" do
    expect(
      [[]].map(push_next)
    ).to eq([[:next]])
  end

  it "can be applied with some additional args" do
    a = []
    pn = a.fn.push :next 
    pn.(2)
    expect(
      a
    ).to eq([:next, 2])
  end

end # describe Object
