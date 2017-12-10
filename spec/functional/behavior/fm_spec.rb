require 'spec_helper'

require 'lab42/core/fn'

describe Module do
  context '#fm' do 
    it 'exist' do
      expect( Module.instance_method :fm ).to be_kind_of UnboundMethod
    end
    it 'and delivers a Proxy' do
      expect( String.fm ).to be_kind_of Lab42::Behavior::Proxy
    end

    context 'behavior' do 
      let( :fm ){ Array.fm.map }
      let( :digits ){ [*0..9] }

      it 'can be bound and invoked in one step' do
        expect( fm.(digits, &:succ) ).to eq [*1..10]
      end

      it 'can be used as a block itself' do
        expect( digits.map(&Integer.fm.succ) ).to eq [*1..10]
      end

      context 'partials' do 

        it 'can be used as a block itself with early binding' do
          incrementer = Array.fm.map(&:succ)
          expect( [[0], [1,2], [3,4,5]].map(&incrementer) ).to eq [[1], [2,3], [4,5,6]]
        end

        it 'can be uses as a block with rebinding; N.B. this is no late binding' do
          expect( [[0], [1,2], [3,4,5]].map(&fm._(&:succ)) ).to eq [[1], [2,3], [4,5,6]]
        end

        context 'can bind with blocks and params as, and when, needed (impmtg: Demo)' do 
          let( :reducer ){ Enumerable.fm.inject }
          let( :summer ){ reducer._(&Fixnum.fm.+) }

          it 'sums, all right' do
            expect( [[1,2]].map(&summer) ).to eq [3]
          end
          
          it 'can be bound very late' do
            expect( Fixnum.fm.+.(1,41) ).to eq 42
          end
          it 'or very early' do
            expect( Fixnum.fm.+(41,1).() ).to eq 42
          end
          

        end # context 'can bind with blocks and params as, and when, needed (impmtg: Demo)'

      end # context 'partials'
    end # context 'behavior'
  end # context '#fm'
end # describe Module
