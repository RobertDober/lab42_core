require 'spec_helper'
require 'lab42/core/console_tools'

describe Lab42 do 
  let( :digits ){ 0..9 }
  
  context 'mm' do 
    context 'Enumerable' do 
      it 'transforms digits' do
        expect( digits.mm :+, 2 ).to eq [*2..11]
      end
      it 'transforms arrays' do
        expect( digits.to_a.mm :+, 2 ).to eq [*2..11]
      end
    end # context 'Range'
  end # context 'mm'
end # describe Lab42
