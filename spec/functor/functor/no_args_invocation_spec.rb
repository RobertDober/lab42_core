require 'spec_helper'

describe Lab42::Functor do 
  context 'no args' do 
    it 'is called with the first IT argument as receiver' do
      expect( F.succ.(41) ).to eq 42
    end
    
  end # context 'no args'
end # describe Lab42::Functor
