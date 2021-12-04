require 'lab42/core/fn'

RSpec.describe Lab42::Meta::Behavior do
  it 'touching a missed edge case here' do
    expect( described_class.behavior([].fn.size).() ).to be_zero
  end
end
# SPDX-License-Identifier: Apache-2.0
