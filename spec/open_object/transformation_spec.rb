require 'spec_helper'
require 'lab42/open_object'

describe OpenObject do 
  subject do
    described_class.new a: 42, b: 44, c: 46
  end

  context :transform_values do 
    it 'creates another instance' do
      expect(
        subject.transform_values(Fixnum.fm./ 2 )
      ).to eq( OpenObject.new a: 21, b: 22, c: 23 )
    end
  end # context :transform_values
end # describe OpenObject
