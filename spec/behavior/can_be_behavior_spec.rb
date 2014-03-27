require 'spec_helper'

describe Lab42::Behavior do
  context :can_be_behavior do 
    it 'returns true for a Proc' do
      expect( described_class.can_be_behavior? ->{} ).to eq( true )
    end
    it 'returns true for a Method' do
      expect( described_class.can_be_behavior? method(:puts) ).to eq( true )
    end
    it 'returns true for a Symbol' do
      expect( described_class.can_be_behavior? :hello ).to eq( true )
    end

    it 'returns false for an Object instance' do
      expect( described_class.can_be_behavior? Object.new ).to eq( false )
    end
    it 'returns false for Object' do
      expect( described_class.can_be_behavior? Object ).to eq( false )
    end
    it 'returns false for a String instance' do
      expect( described_class.can_be_behavior? 'hello' ).to eq( false )
    end
    
  end # context :can_be_behavior
end # describe Kernel
