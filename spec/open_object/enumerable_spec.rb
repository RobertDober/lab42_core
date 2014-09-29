
require 'spec_helper'
require 'lab42/core/open_object'

describe OpenObject do
  subject do
    described_class.new a: 42, b: 43
  end
  context 'Enumerable' do 
    context 'each and friends' do 
      it 'will iterate' do
        d = double
        expect( d ).to receive(:msg).with(described_class.new(a: 42)).ordered
        expect( d ).to receive(:msg).with(described_class.new(b: 43)).ordered
        subject.each{ |x| d.msg x }
      end
      it 'will thus map too' do
        expect( subject.map(&:values) ).to eq([[42], [43]])
      end
    end # context 'each and friends'
  end # context Enumerable
end
