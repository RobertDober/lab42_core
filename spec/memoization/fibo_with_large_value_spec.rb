require 'spec_helper'

describe Module do

  context 'memoized, one param, (read Fibonacci)' do 

    module Fibo extend self
      memoize def fibo n
        n < 2 ? n : fibo( n - 1 ) + fibo( n - 2 )
      end
    end


    unless RUBY_PLATFORM == "java" 
    it 'no counting here, if it can compute it without having U 2 wait, it is memoized for sure ;)' do
      expect( Fibo.fibo 1_000 ).to eq 43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875 
    end
    end
  end # context 'memoized, parameterless methods'
end
