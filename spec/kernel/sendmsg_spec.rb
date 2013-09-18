require 'spec_helper'

describe Kernel do
  context :sendmsg do 
    let(:source){[*0..8]}
    let(:target){[*1..9]}

    it "replaces &kludge" do
      expect(
        source.map(&sendmsg(:succ))
      ).to eq( target )
    end

    it "is a proc" do
      expect(
        sendmsg(:+, 2).(40)
      ).to eq( 42 )
    end
  end # context :sendmsg
end # describe Kernel
