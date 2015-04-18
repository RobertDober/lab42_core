require 'spec_helper'

describe Module do
  context 'lazy_attr' do 
    it 'raises an ArgumentError without a block' do
      expect{ Module.new{ lazy_attr :a } }.to raise_error ArgumentError, %r{missing initialization block}
    end

    it 'evaluates the block in instance context' do
      m = Module.new{ lazy_attr( :a ){ 2 * b } }
      k = Class.new{ attr_accessor :b }
      i = k.new.extend m
      i.b = 21
      expect( i.a ).to eq 42
    end

    context 'evaluates lazy attributes as needed' do
      let :klass do
        Class.new do
          lazy_attr(:a){ 2 * b }
          lazy_attr(:b){ c.succ }
          lazy_attr(:c){ 20 }
        end
      end

      it 'still gets us an expectable result' do
        expect( klass.new.a ).to eq 42
      end
    end

    context 'does not share them ' do 
      let :klass do
        Class.new do
          attr_reader :b
          lazy_attr(:a){ 2 * b }
          def initialize b; @b=b end
        end
      end
      it 'between instances' do
        a = klass.new 0
        b = klass.new 21
        a.a
        b.a
        expect( a.a ).to be_zero
        expect( b.a ).to eq 42
      end
    end # context 'does not share them between instances'
  end # context 'lazy_attr'
end # describe Module
