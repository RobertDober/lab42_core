require 'spec_helper'
require 'lab42/core/fn/iterator_reimpl'

describe Lab42::Core::IteratorReimpl do

  context :determine_behavior do
    let(:block){->{}}

    context 'ArgumentError is raised if no behavior is found' do 

      it 'for no params' do
        expect(
          -> {described_class.decompose_args [], nil}
        ).to raise_error(ArgumentError, "No behavior specified")
      end

      it 'for no symbol and no proc (one param)' do
        expect(
          -> {described_class.decompose_args [1], nil}
        ).to raise_error(ArgumentError, "No behavior specified")
      end

      it 'for no symbol and no proc (many params)' do
        expect(
          -> {described_class.decompose_args [1, "2"], nil}
        ).to raise_error(ArgumentError, "No behavior specified")
      end

    end # context 'ArgumentError is raised if no behavior is found'

    context 'no block given' do 
      context 'Symbol is found' do 
        let(:behavior){:a}
        
        it 'has only symbol' do
          expect( described_class.decompose_args [behavior], nil ).to eq([[], behavior])
        end
        it 'has symbol preceded by value' do
          expect( described_class.decompose_args [behavior,:b], nil ).to eq([[behavior], :b])
        end 
        it 'has value preceded by symbol' do
          expect( described_class.decompose_args [behavior,42], nil ).to eq([[42], behavior])
        end 
      end # context 'Symbol is found'

      context 'Proc is found' do 
        let(:behavior){->{}}
        
        it 'has only callable' do
          expect( described_class.decompose_args [behavior], nil ).to eq([[], behavior])
        end
        it 'has callable preceded by value' do
          expect( described_class.decompose_args [behavior,:b], nil ).to eq([[behavior], :b])
        end 
        it 'has value preceded by callable' do
          expect( described_class.decompose_args [behavior,42], nil ).to eq([[42], behavior])
        end 
      end # context 'Proc is found'

      context 'Method is found' do 
        let(:behavior){ ''.fn.size }
        
        it 'has only callable' do
          expect( described_class.decompose_args [behavior], nil ).to eq([[], behavior])
        end
        it 'has callable preceded by value' do
          expect( described_class.decompose_args [behavior,:b], nil ).to eq([[behavior], :b])
        end 
        it 'has value preceded by callable' do
          expect( described_class.decompose_args [behavior,42], nil ).to eq([[42], behavior])
        end 
      end # context 'Method is found'
    end # context 'no block given'

    context 'block given' do 

      context 'Symbol is found' do 
        let(:behavior){:a}
        
        it 'has only symbol' do
          expect( described_class.decompose_args [behavior], block ).to eq([[behavior], block])
        end
      end # context 'Symbol is found'

    end # context 'block given'

    context 'three args is too much' do 
      
      it 'raises error if there are three...' do
        expect(
          ->{ described_class.decompose_args [1,2,3], block }
        ).to raise_error( ArgumentError, %r{too many arguments})
      end

      it '... or more' do
        expect(
          ->{ described_class.decompose_args [1,2,3,4], block }
        ).to raise_error( ArgumentError, %r{too many arguments})
      end
      it 'raises error if there are two and a block' do
        expect(
          ->{ described_class.decompose_args [1,2], ->{} }
        ).to raise_error( ArgumentError, %r{too many arguments})
      end
    end # context 'three args is too much'

  end # context :determine_behavior
end # describe Lab42::Core::IterReimpl
