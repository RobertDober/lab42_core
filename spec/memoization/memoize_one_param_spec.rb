require 'spec_helper'

describe Module do

  context 'memoized, one param, (read Fibonacci)' do 

    module Fibo extend self
      memoize def fibo n
        n < 2 ? n : fibo( n - 1 ) + fibo( n - 2 )
      end
    end


    it 'no counting here, if it can compute it without having U 2 wait, it is memoized for sure ;)' do
      expect( Fibo.fibo 10_000 ).to eq 1
    end
  end # context 'memoized, parameterless methods'

end # describe Module
