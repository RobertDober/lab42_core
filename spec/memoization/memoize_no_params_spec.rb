require 'spec_helper'

describe Module do
  context 'undefined methods remain undefined' do 

    let :klass do
      Class.new do
        memoize :beta
      end
    end

    it 'raises a NoMethod error' do
      expect{ klass.new.beta  }.to raise_error NameError, %r{undefined method .beta.} 
    end

  end # context 'undefined methods remain undefined'

  context 'memoized, parameterless methods' do 

    let :klass do
      Class.new do
        attr_reader :x
        memoize def alpha; @x||=0; @x+=1; 'alpha' end
      end
    end
    let( :instance ){ klass.new }

    it 'x returns always the same result' do
      expect( 3.times.map{ instance.alpha }.join ).to eq 'alpha' * 3
    end
    it 'x is initially nil' do
      expect( instance.x ).to be_nil
    end
    it 'is 1 after a memoized call' do
      instance.alpha
      expect( instance.x ).to eq 1
    end
    it 'is 1 after many memoized calls' do
      3.times{ instance.alpha }
      expect( instance.x ).to eq 1
    end

  end # context 'memoized, parameterless methods'

end # describe Module
# SPDX-License-Identifier: Apache-2.0
