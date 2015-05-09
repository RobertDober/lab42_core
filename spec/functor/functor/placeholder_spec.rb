require 'spec_helper'

describe Lab42::Functor do

  context 'placeholder in first position' do
    let( :decrementer ){ F.-(F, 1) }
    it 'is a functor' do
      expect( decrementer ).to be_kind_of described_class
    end
    it 'decrements correctly' do
      expect( decrementer.(43) ).to eq 42
    end
  end # context 'placeholder in first position'

  context 'placeholder missfits', :wip do
    context 'raises ArgumentError' do 
      it 'for too few IT arguments' do
        expect{ F.any("a", F, "b", F, "c").("d") }.to raise_error ArgumentError, %r{wrong number of arguments \(1 for 2\.\.\)}
        
      end
    end # context 'raises ArgumentError'
  end # context 'placeholder missfits'

end # describe Functor
