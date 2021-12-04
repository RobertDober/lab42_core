require 'spec_helper'

describe Enumerable do
 
  shared_examples_for 'a digit yielder' do
    it 'yields zero' do
      expect( subject.() ).to be_zero
    end

    it 'yields all other digits too' do
      x = []
      subject.()
      loop do
        x << subject.()
      end
      expect( x ).to eq [*1..9]
    end

    it 'can be reset' do
      loop{ subject.() }
      subject.reset!
      expect( subject.() ).to be_zero
    end
  end

  context Array do 
    subject do
      [*0..9].to_proc
    end
    it_behaves_like 'a digit yielder'
  end # context Array

  context Enumerable do 
    subject do
      (0..9).to_proc
    end
    it_behaves_like 'a digit yielder'
  end # context Enumerable

  context Enumerator do 
    subject do
      (0..9).to_enum.to_proc
    end
    it_behaves_like 'a digit yielder'
  end # context Enumerator

  context Enumerator::Lazy do 
    subject do
      (0..9).to_enum.lazy.to_proc
    end
    it_behaves_like 'a digit yielder'
  end # context Enumerator
end
# SPDX-License-Identifier: Apache-2.0
