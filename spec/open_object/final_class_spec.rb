require 'spec_helper'
require 'lab42/core/open_object'

describe Lab42::Core::OpenObject do 
  subject do
    described_class
  end
  it 'cannot be subclassed' do
    expect( ->{c = Class.new( subject )} ).to raise_error
  end
end # describe Lab42::Core::OpenObject
