require 'b_helper'

describe 'Behave' do 
 
  context "arity is relative" do 
    it 'works for 1' do
      expect( (1..2).map(&B(:-, 1)) ).to eq [0, 1]
    end
    it 'and it works for 2' do
      expect( (1..3).inject(&B(:+)) ).to eq 6
    end
  end # context "arity is relative"

  context "LIFO Priniciple" do 
    it 'addes early params at the end' do
      expect( B(:<<, :end).([:begin]) ).to eq [:begin, :end]
    end
  end # context "LIFO Priniciple"
end # describe Behave, :wip
