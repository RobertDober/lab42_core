require 'spec_helper'

describe F do 
  it 'is the Functor Factory' do
    expect( described_class ).to eq Lab42::Functor::Factory
  end

  it 'which gets us functors' do
    expect( described_class.some_message ).to be_kind_of Lab42::Functor
  end
end # describe F
