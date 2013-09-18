require 'spec_helper'

describe Kernel do 
  context :sendmsg do 
    let(:source){[*0..8]}
    let(:target){[*1..9]}
    it "replaces &kludge" do
      expect(
        source.map(&sendmg(:succ))
      ).to eq( target )
    end
  end # context :sendmsg
end # describe Kernel
