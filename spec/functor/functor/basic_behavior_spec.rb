require 'spec_helper'

describe Lab42::Functor do

  context 'ct args vs. it args' do 
    
     it 'no ct args' do
       expect( F.+.("a","b") ).to eq "ab"
     end

     it '1 of each' do
       expect( F.+("c").("d") ).to eq 'cd'
     end

     it 'no it args' do
       expect( F.+('e','f').() ).to eq 'ef'
     end
  end # context 'ct args vs. it args'
end # describe Functor
