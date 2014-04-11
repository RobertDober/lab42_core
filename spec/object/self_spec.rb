require 'spec_helper'

describe Object do
  it "is itself" do
    o = Object.new
    expect( o.self ).to eq( o )
  end

  it "worx on all levels" do
    expect( Class.self ).to eq( Class )
  end

  it "even for modules" do
    expect( Kernel.self ).to eq( Kernel )
  end
end
