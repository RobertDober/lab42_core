require 'spec_helper'

describe Object do
  let( :attr ){ 
    Module.new do
      extend self
      lazy_attr(:a) { 0 }
      lazy_attr(:a!){ 1 }
      lazy_attr(:a?){ 2 }
      @__a__ = 42
      def a_; @__a__ end
    end
  }
  
  it 'does not erase @__a__' do
    expect( attr.a_ ).to eq 42
    expect( attr.a ).to eq 0
    expect( attr.a_ ).to eq 42
  end

  it 'has lazy bang' do
    expect( attr.a! ).to eq 1
  end

  it 'has lazy ?' do
    expect( attr.a! ).to eq 2
  end
end # describe Object
