require 'spec_helper'

describe Proc do
  context 'not negates' do 
    subject do
      ->(a){a}.not
    end

    it true do
      expect( subject.(true) ).to eq false
    end

    it :false do
      expect( subject.(false) ).to eq true
    end

  end # context :not
end # describe Proc
