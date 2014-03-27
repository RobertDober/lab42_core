require 'spec_helper'
require 'lab42/core/kernel'

describe Lab42::Core::Behavior do
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

    it 'is mixed in from Behavior' do
      expect(
        described_class.sendmsg(:< , 10).(1)
      ).to eq( true )
    end
  end # context :sendmsg
end # describe Kernel
