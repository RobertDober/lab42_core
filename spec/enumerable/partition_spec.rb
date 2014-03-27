require 'spec_helper'
require 'lab42/core/enumerable'

describe Enumerable do 
  context :partition, :wip do
    context 'the old way' do 
      it 'still worx' do
        expect(
          (1..10).partition{ |x| x.odd? }
        ).to eq([ [1,3,5,7,9], [2,4,6,8,10] ])
      end
    end # context 'the old way'

    context 'the new way' do 
      it 'allows to use a symbol for the block' do
        expect(
          (1..10).partition :odd?
        ).to eq([ [1,3,5,7,9], [2,4,6,8,10] ])
        
      end
    end # context 'the new way'
  end # context :partition
end # describe Enumerable
