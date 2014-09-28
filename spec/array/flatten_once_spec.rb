require 'spec_helper'

describe Array do 
  context 'flatten_once' do 
    it 'works on empty' do
      expect( [].flatten_once ).to be_empty
    end
    it 'works on flat' do
      expect( %w{a b c}.flatten_once ).to eq %w{a b c}
    end
    it 'flattens once' do
      expect( [ %w{a b}, %w{c d} ].flatten_once ).to eq %w{a b c d}
    end
    it 'but not more' do
      expect( [%w{a b}, [%w{c d} ]].flatten_once ).to eq ['a', 'b', %w{c d} ]
    end
    it 'leaves Hashes alone' do
      expect( [%w{a}, [1, {a: 1}], {a: 2}].flatten_once ).to eq ['a', 1, {a: 1}, {a: 2}]
    end
    it 'leaves Enums alone' do
      expect( [(1..1), [(1..2)]].flatten_once ).to eq [(1..1), (1..2)]
    end
  end # context 'flatten_once'
end # describe Array
