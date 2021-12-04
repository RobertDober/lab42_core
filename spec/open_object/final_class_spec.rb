require 'lab42/core/open_object'

describe OpenObject do 
  subject do
    described_class
  end
  context 'cannot be subclassed' do
    it{ expect( ->{ Class.new( subject )} ).to raise_error( RuntimeError, %r{I prefer delegation} ) }
  end
end
# SPDX-License-Identifier: Apache-2.0
