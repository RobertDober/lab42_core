require 'spec_helper'

describe Object do 
  let( :klass ){ 
    Class.new do
      memo :a do 42 end
      def a_; @__a__ end

      def initialize; @__a__ = 0 end
    end
  }
  let( :instance ){ klass.new }
  

  it 'does not override the instance variable' do
    expect( instance.a_ ).to be_zero
    expect( instance.a ).to eq 42
    expect( instance.a_ ).to be_zero
  end
  
end # describe Object
