require 'spec_helper'

describe Lab42::Functor do 
  context 'ct args before it args' do 
    it{
      expect( (1..3).map(&F.-(10)) ).to eq [9, 8, 7]
    }

  end # context 'no args'
end # describe Lab42::Functor
