require 'spec_helper'
require 'lab42/core/fn'

describe "Frozen Objects" do
  
  let(:source){4..7}
  let(:expected){[*6..9]}

  it "can use fn" do
    expect( 2.fn.+.(40) ).to eq( 42 )
  end

end # describe "Frozen Objects"
