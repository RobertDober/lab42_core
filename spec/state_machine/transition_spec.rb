require 'lab42/core/state_machine'

RSpec.describe Lab42::Core::StateMachine::Transition do

  context 'default rgx behavior' do 
    let( :transition ){ described_class.new(:to_state, %r{\A```(?<lang>\w+)}) }

    it 'matches on a string' do
      match = transition.match '```lisp', 42
      expect( match.transition ).to eq(transition)
      expect( match.data['lang'] ).to eq( 'lisp' )
      expect( match.line ).to eq( '```lisp' )
      expect( match.index ).to eq(42)
      expect( match.state ).to eq(:to_state)
    end

  end


end
