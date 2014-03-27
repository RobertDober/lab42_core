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

      it 'allows to use a proc' do
        expect(
          (1..10).partition sendmsg(:odd?) 
        ).to eq([ [1,3,5,7,9], [2,4,6,8,10] ])
      end

      it 'but not both' do
        expect(
          ->{ (1..2).partition :odd, sendmsg(:odd?) }
        ).to raise_error( ArgumentError )
      end

      it 'neither a block and a behavior' do
        expect(
          ->{ (1..2).partition :odd do end }
        ).to raise_error( ArgumentError )
      end

      it 'or any other parameter' do
        expect(
          ->{ (1..2).partition 'odd' do end }
        ).to raise_error( ArgumentError )
      end
    end # context 'the new way'
  end # context :partition
end # describe Enumerable
