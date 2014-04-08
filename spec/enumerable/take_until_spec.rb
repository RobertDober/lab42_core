require 'spec_helper'
require 'lab42/core/enumerable'

describe Enumerable do 
  
  context "take_while with accumulator (ary)" do 
    subject do
      %w{alpha beta gamma delta epsilon}
    end

    it 'passes the accumulator' do
      expect( subject.take_while { |_,acc|
                                   acc.join(' ').size < 10
      }).to eq( %w{alpha beta} )
    end
  end # context "take_while with accumulator"
  
  
  context "take_while with accumulator (enum)" do 
    subject do
      1..100
    end

    # REMARK:
    # Would it not be lovely to write the expression below as:
    #    subject.inject_while(0, :+, sendmsg(:<, 100))
    it 'passes the accumulator' do
      expect( subject.take_while { |_,acc|
                                   acc.inject( 0, :+ ) < 100
      }).to eq( [*1..14] )
    end
  end # context "take_while with accumulator"
  
end # describe Enumerable
