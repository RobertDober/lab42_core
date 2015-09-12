require 'spec_helper'

module Memo
  memo :upcase do |name|
    count[name] += 1
    name.upcase
  end
end # module Memo

describe Memo do 
  let( :klass ){ 
    Class.new do
      include Memo
      attr_reader :count
      def initialize; @count=Hash.new{|h,k| h[k]=0 } end
    end
  }
  let( :testee ){ klass.new }
  
  it 'memoizes' do
    testee.upcase "alpha"
    testee.upcase "beta"
    expect( testee.upcase 'alpha' ).to eq 'ALPHA'
    expect( testee.upcase "beta" ).to eq 'BETA'
    expect( testee.count ).to eq 'alpha' => 1, 'beta' => 1
  end

  it 'and unmemoizes' do
    testee.upcase "alpha"
    testee.upcase "beta"
    expect( testee.upcase 'alpha' ).to eq 'ALPHA'
    expect( testee.upcase "beta" ).to eq 'BETA'
    expect( testee.count ).to eq 'alpha' => 1, 'beta' => 1
    testee.unmemoize_memo_upcase 'alpha'
    expect( testee.upcase 'alpha' ).to eq 'ALPHA'
    expect( testee.upcase "beta" ).to eq 'BETA'
    expect( testee.count ).to eq 'alpha' => 2, 'beta' => 1
    testee.unmemoize_memo_upcase
    expect( testee.upcase 'alpha' ).to eq 'ALPHA'
    expect( testee.upcase "beta" ).to eq 'BETA'
    expect( testee.count ).to eq 'alpha' => 3, 'beta' => 2
  end
  
  
end # describe Memo
