require 'lab42/core/state_machine'
RSpec.describe Lab42::Core::StateMachine do

  class MyDocReader1
    include Lab42::Core::StateMachine

    add_transition :start, %r{\A```(?<lang>\w*)}, :create_new_entry, to: :inside
    add_transition :inside, %r{\A```\s*\z},       nil,               to: :start
    add_transition :inside, true do |match|
      object[object[:last_index]] << match.line 
    end

    after_last_input :cleanup
   
    def cleanup
      object.delete :last_index
    end

    def create_new_entry match
      object.update match.index.succ => [], last_index: match.index.succ
    end

  end

  describe MyDocReader1 do
    let( :lines ){ %w{alpha ```ruby code ``` ```elixir more_code ```ruby still_elixir ``` the_end} }
    let( :reader ){ MyDocReader1.new(:start, {}) }


    it { 
      expect(reader.run(lines)).to eq({ 2 => %w{code}, 
                                           5 => %w{more_code ```ruby still_elixir} }) }
    
  end
end
# SPDX-License-Identifier: Apache-2.0
