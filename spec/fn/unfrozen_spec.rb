require 'spec_helper'
require 'lab42/core/fn'

describe Object do
  let(:source){8..11}
  let(:expected){[9,1,2,3]}

  it "can use fn" do
    expect( Integer.fn.cksum.(12) ).to eq( 4 )
  end
end # describe Object
