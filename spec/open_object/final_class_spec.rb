require 'spec_helper'
require 'lab42/core/open_object'

describe OpenObject do 
  subject do
    described_class
  end
  context 'cannot be subclassed' do
    it{ expect( ->{c = Class.new( subject )} ).to raise_error, /RuntimeError: I prefer delegation/ }
  end
end
