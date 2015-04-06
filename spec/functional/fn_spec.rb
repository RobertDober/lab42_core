require 'spec_helper'

require 'lab42/core/fn'

describe Object do
  context 'fn' do 

    it 'exist' do
      expect( Object.instance_method :fn ).to be_kind_of UnboundMethod
    end
    it 'and delivers a Proxy' do
      expect( Array.fn ).to be_kind_of Lab42::Behavior::Proxy
    end

    context 'behvaior' do 

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

    end # context 'behvaior'

    context 'curried' do 
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
    end # context 'curried'

    context 'with blox' do 
      let( :fn ){ (0..9).fn.map }

      it 'can be invoked' do
        expect( fn.(&:succ) ).to eq [*1..10]
      end
    end # context 'curried'

    context 'with args and blox' do 
      let( :fn ){ {a: 1, b: 2}.fn.merge  }

      it 'can be invoked' do
        expect( fn.(a:10, c:10 ){|_,old,new| new - old } ).to eq a: 9, b: 2, c: 10
      end
    end # context 'with args and blox'

    context 'partial application of blox' do 
      let( :fn ){ {a: 1, b: 2}.fn.merge{|_, old, new| old + new}  }

      it 'can be invoked' do
        expect( fn.( a: 8, c: 10 ) ).to  eq a: 9, b: 2, c: 10
      end

      it 'but late bingding superseeds early' do
        expect( fn.( a: 8, c: 10 ){ |_,o,n| n - o } ).to eq a: 7, b: 2, c: 10
      end
      
    end # context 'partial application of blox'
  end # context 'Object#fn'
end # describe 'Functional'
