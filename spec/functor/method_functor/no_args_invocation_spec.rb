require 'spec_helper'

describe Lab42::MethodFunctor do 
  context 'no args' do 
    it 'is called with the first IT argument as receiver' do
      expect( M.succ.(41) ).to eq 42
    end
    it 'early binding is not possible' do
      expect{ M.succ(42).(41) }.to raise_error ArgumentError, %r{wrong number of arguments \(1 for 0\)}
    end
  end # context 'no args'
  
end # describe Lab42::MethodFunctor
