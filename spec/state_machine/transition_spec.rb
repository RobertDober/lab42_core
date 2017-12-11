require 'lab42/core/state_machine'

RSpec.describe Lab42::Core::StateMachine::Transition do

  let( :handler ){ double 'handler' }
  let( :state ){ double 'state' }


  context 'default rgx behavior' do 
    let( :transition ){ described_class.new(state, %r{\A```(?<lang>\w+)}) }

    it 'matches on a string' do
      match = transition.match '```lisp', 42, handler
      expect( match.transition ).to eq(transition)
      expect( match.data['lang'] ).to eq( 'lisp' )
      expect( match.line ).to eq( '```lisp' )
      expect( match.index ).to eq(42)
      expect( match.state ).to eq(state)
      expect( match.handler ).to eq(handler)
    end
  end

  context 'proc behavior' do 
    let( :transition ){ described_class.new(state, ->(a){ a < 'hello' }) }

    it 'matches a line' do
      match = transition.match 'friends', 42, handler
      expect( match.transition ).to eq(transition)
      expect( match.data ).to eq( true )
      expect( match.line ).to eq( 'friends' )
      expect( match.index ).to eq(42)
      expect( match.state ).to eq(state)
      expect( match.handler ).to eq(handler)
    end

    it 'or not' do
      expect( transition.match 'world', 42, handler ).to be_nil
    end
  end

  context 'you cannot make a behavior like that' do 
    it { expect{ described_class.new(state, 'Hello') }.to raise_error(ArgumentError) }
  end


end
