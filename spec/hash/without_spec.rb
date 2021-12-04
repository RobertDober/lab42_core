RSpec.describe Hash do
  context 'empty' do
    it { expect({}.without(:a)).to be_empty }
    it { expect({a: 1}.without(:a)).to be_empty }
  end

  context 'untouched' do 
    it { expect({a: 1}.without('a')).to eq(a: 1) }
  end

  context 'mixed' do 
    it { expect({a: 1, b: 2}.without(:b)).to eq(a: 1) }
  end

end
# SPDX-License-Identifier: Apache-2.0
