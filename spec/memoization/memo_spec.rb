require 'spec_helper'
describe Object do

  shared_examples_for 'memo' do
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

  context 'memo' do 

    context 'class' do 
      class A
        attr_reader :count
        def initialize; @count = 0 end
        memo( :a ){ |n| @count+=1 }
      end

      let( :subject ){ A.new }
      it_behaves_like 'memo' 

    end # context 'shared'

    context 'module' do 
      module M
        attr_reader :count
        def initialize; @count = 0 end
        memo( :a ){ |n| @count+=1 }
      end

      let( :subject ){ Class.new.send(:include, M).new }
      it_behaves_like 'memo' 
    end # context 'inline'
    
    context 'singleton module' do 
      module SM extend self
        attr_reader :count
        @count = 0
        memo( :a ){ |n| @count+=1 }
      end

      let( :subject ){ SM }
      it_behaves_like 'memo' 
      
    end # context 'singleton module'

    context 'extended object' do 
      module M
        attr_reader :count
        @count = 0
        memo( :a ){ |n| @count+=1 }
      end

      let( :subject ){ Object.new.extend( M ).tap{ |o| o.instance_eval{ @count=0 }}}
      it_behaves_like 'memo' 
      
    end # context ''
  end # context 'memoized, one param inline'

end
