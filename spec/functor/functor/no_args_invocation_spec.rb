require 'spec_helper'

describe Lab42::Functor do 
  context 'no args' do 
    it 'is called with the first IT argument as receiver' do
      expect( F.succ.(41) ).to eq 42
    end

    context 'early binding' do
      let( :functor ){ F.succ( 41 ) }
      it 'has a callable' do
        expect( functor.callable ).to be_kind_of Method
      end
      it 'which is invoked' do
        expect( functor.callable ).to receive(:call).with( no_args )
        functor.()
      end
    end
  end # context 'no args'
end # describe Lab42::Functor
