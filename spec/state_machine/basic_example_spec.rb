require 'lab42/core/state_machine'

RSpec.describe Lab42::Core::StateMachine do
  
  class MyDocReader
    include Lab42::Core::StateMachine

    add_transition :start, %r{\A```(?<lang>\w*)}, :create_new_entry, to: :inside
    add_transition :inside, %r{\A```\s*\z},       nil,               to: :start
    add_transition :inside, true,                 :add_to_entry             

    def add_to_entry match
      object[object[:last_index]] << match.line 
    end
    def create_new_entry match
      object.update match.index.succ => [], last_index: match.index.succ
    end

  end

  describe 'reading lines' do
    let( :lines ){ %w{alpha ```ruby code ``` ```elixir more_code ```ruby still_elixir ``` the_end} }
    let( :reader ){ MyDocReader.new(:start, {}) }


    it { expect(reader.run(lines)).to eq({ last_index:  5,
                                           2 => %w{code}, 
                                           5 => %w{more_code ```ruby still_elixir} }) }
    
  end

end
# SPDX-License-Identifier: Apache-2.0
