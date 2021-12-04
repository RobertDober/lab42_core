require 'spec_helper'
describe Object do

  shared_examples_for 'memoized with one param' do
    it 'returns 1 for applications with a first value' do
      expect( subject.a 42 ).to eq 1
      expect( subject.a 42 ).to eq 1
    end
    it 'returns 2 for application with a second value' do
      expect( subject.a 42 ).to eq 1
      expect( subject.a 43 ).to eq 2
      expect( subject.a 42 ).to eq 1
    end
  end

  context 'memoized, one param' do 

    context 'class' do 
      class A
        attr_reader :count
        def initialize; @count = 0 end
        memoize def a n; @count+=1 end
      end

      let( :subject ){ A.new }
      it_behaves_like 'memoized with one param' 

    end # context 'shared'

    context 'module' do 
      module M
        attr_reader :count
        def initialize; @count = 0 end
        memoize def a n; @count+=1 end
      end

      let( :subject ){ Class.new.send(:include, M).new }
      it_behaves_like 'memoized with one param' 
    end # context 'inline'
    
    context 'singleton module' do 
      module SM extend self
        attr_reader :count
        @count = 0
        memoize def a n; @count+=1 end
      end

      let( :subject ){ SM }
      it_behaves_like 'memoized with one param' 
      
      
    end # context 'singleton module'

    context 'extended object' do 
      module M
        attr_reader :count
        @count = 0
        memoize def a n; @count+=1 end
      end

      let( :subject ){ Object.new.extend( M ).tap{ |o| o.instance_eval{ @count=0 }}}
      it_behaves_like 'memoized with one param' 
      
    end # context ''
  end # context 'memoized, one param inline'

end
# SPDX-License-Identifier: Apache-2.0
