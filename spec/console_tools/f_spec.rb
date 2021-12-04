require 'spec_helper'
require 'lab42/core/console_tools'

describe Lab42 do 

  context 'f' do 
    it 'is simply a function' do
      expect( f("Hello", :size).() ).to eq 5
    end
    it 'is param agnostic, important for mappings' do
      expect( f("Hello", :size).(1) ).to eq 5
    end

    context 'implicit receiver' do 
      context 'in case of a leading Symbol the receiver is passed in as first arg' do
        it 'as in the classical sendmsg example' do
          expect( f(:size).("Hello") ).to eq 5
        end
        
      end
    end # context 'implicit receiver'
  end # context 'f'
  
end # describe Lab42

# SPDX-License-Identifier: Apache-2.0
