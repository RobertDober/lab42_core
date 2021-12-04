require 'spec_helper'

describe Object do 
  context "parameterless methods" do
    let( :counter_class ){ 
      Class.new do
        memo :count do
          @c += 1
        end
        private
        def initialize; @c=0 end
      end
    }
    let( :counter ){ counter_class.new }
    
    context "unmemoization" do 
      it "is unemoizing a memoized value" do
        counter.count
        expect( counter.count ).to eq 1
        counter.unmemoize_memo_count
        expect( counter.count ).to eq 2
      end
      
    end # context "unmemoization"
    context "unmemoization is a temporary action" do 
      it "is unemoizing a memoized value -- but only once" do
        counter.count
        expect( counter.count ).to eq 1
        counter.unmemoize_memo_count
        expect( counter.count ).to eq 2
        expect( counter.count ).to eq 2
      end
    end # context "unmemoization is a temporary action"
  end

  context "unmemoization off parameterized methods" do 
    let( :counter_class ){ 
      Class.new do
        memo :count do | what |
          @buckets[ what ] += 1
        end
        private
        def initialize
          @buckets = Hash.new{ |h, k| h[k] = 0 }
        end
      end
    }
    let( :counter ){ counter_class.new }
      
    context "unmemoize all" do 
      it 'resets memoization for all possible values' do
        counter.count :alpha
        counter.count :beta
        expect( counter.count :alpha ).to eq 1
        expect( counter.count :beta ).to eq 1
        counter.unmemoize_memo_count
        expect( counter.count :alpha ).to eq 2
        expect( counter.count :beta ).to eq 2
      end
      it 'resets memoizatio only for one value' do
        counter.count :alpha
        counter.count :beta
        expect( counter.count :alpha ).to eq 1
        expect( counter.count :beta ).to eq 1
        counter.unmemoize_memo_count :alpha
        expect( counter.count :alpha ).to eq 2
        expect( counter.count :beta ).to eq 1
      end
    end # context "unmemoize all"
  end # context "unmemoization off parameterized methods"
end # describe Objet

# SPDX-License-Identifier: Apache-2.0
