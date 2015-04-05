require 'spec_helper'

describe Lab42::Meta do
  let( :behavior ){ described_class.method :Behavior }

  context "if last argument is a proc" do 
    let( :a_proc ){ ->{ } }
    
    it 'returns it' do
      expect( behavior.( a_proc ) ).to eq a_proc
    end
    it 'does not worry about params in front' do
      expect( behavior.( 42, a_proc ) ).to eq a_proc
    end
    it 'unless a block was provided' do
      a_block = ->{ }
      expect( behavior.( a_proc, &a_block ) ).to eq a_block
    end
  end # context "if first argument is a proc return it"

  context 'if first argument is a symbol' do 
    context 'it returns a proc that sends the symbol to the first parameter of itself' do 
      let( :spy ){ 'hello' }
      
      it{
        expect( behavior.( :reverse ).( spy ) ).to eq spy.reverse
      }

    end # context 'it returns a proc that sends the symbol to the first parameter of itself'
  end # context 'if first argument is a symbol'
  
  context 'if last argument is a Behavior' do 
    pending "need to spec fn/fm first"
  end # context 'if last argument is a Behavior'
  
end # describe Lab42::Meta
