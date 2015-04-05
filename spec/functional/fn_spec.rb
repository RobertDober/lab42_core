require 'spec_helper'

require 'lab42/core/fn'

describe 'Functional' do
  context 'Object#fn' do 

    let( :instance_add ){ 41.fn.+  }
  
    it 'returns a Lab42::Behavior object' do
      expect(instance_add).to be_kind_of Lab42::Behavior
    end

    it 'has arity 1' do
      expect( instance_add.arity ).to eq 1
    end

    it 'can be converted to a proc' do
      expect( instance_add.to_proc.(1) ).to eq 42
    end

    it 'or be invoked directly' do
      expect( instance_add.(1) ).to eq 42
      expect( instance_add[1] ).to eq 42
    end

  end # context 'Object#fn'

  context 'curried Object#fn' do 
    let( :curried_add ){ 41.fn.+ 1  } 
    
    it 'returns a Lab42::Behavior object too' do
      expect(curried_add).to be_kind_of Lab42::Behavior
    end

    it 'has arity 0' do
      expect( curried_add.arity ).to be_zero
   end

    it 'can be converted to a proc' do
      expect( curried_add.to_proc.() ).to eq 42
    end

    it 'or be invoked directly' do
      expect( curried_add.() ).to eq 42
      expect( curried_add[] ).to eq 42
    end
  end # context 'curried Object#fn'
end # describe 'Functional'
