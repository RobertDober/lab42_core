require 'spec_helper'
require 'lab42/core/module'

describe Module do

  before do
    $count = 0 
  end
  subject do
    Object.new.tap do |o|
      class << o
        def fibo n
          $count += 1
          n < 2 ? 1 : fibo(n-1) + fibo(n-2)
        end
        memoize :fibo, by: ->(n){n}
      end
    end
  end

  it "worx" do
    expect( subject.fibo(7) ).to eq(21)
  end

  it "memoizes" do
    subject.fibo(7)
    expect( $count ).to eq(8)
  end
  
  it "clears the cache" do
    subject.fibo(7)
    subject.fibo(6)
    expect( $count ).to eq(15)
  end
end
