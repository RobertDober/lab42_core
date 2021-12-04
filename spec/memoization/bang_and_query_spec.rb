require 'spec_helper'

describe Object do 
  context "bang and query" do
    let( :counter_class ){ 
      Class.new do
        memo :count do
          @c += 1
        end
        memo :count! do
          @c += 10
        end
        memo :count? do
          @c += 100
        end
        private
        def initialize; @c=0 end
      end
    }
    let( :counter ){ counter_class.new }
    
    context "memoization and unmemoization" do 
      it "of count" do
        counter.count
        expect( counter.count ).to eq 1
        counter.unmemoize_memo_count
        expect( counter.count ).to eq 2
        expect( counter.count ).to eq 2
      end
      it "of count!" do
        counter.count!
        expect( counter.count! ).to eq 10
        counter.unmemoize_memo_count!
        expect( counter.count! ).to eq 20
        expect( counter.count! ).to eq 20
      end
      it "of count?" do
        counter.count?
        expect( counter.count? ).to eq 100
        counter.unmemoize_memo_count?
        expect( counter.count? ).to eq 200
        expect( counter.count? ).to eq 200
      end
    end # context "unmemoization"
  end

end # describe Objet

# SPDX-License-Identifier: Apache-2.0
