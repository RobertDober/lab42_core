require 'spec_helper'

describe Dir do

  def pair local_path
    [ local_path, File.join(ENV["PWD"], local_path) ]
  end

  context ".file with callables " do 
    before do
      stub_dir_with_content "hello/world", "a/d", "b/c"
    end
    let :expected do
      [ pair( "a/d" ), pair( "b/c" ) ]
    end

    context 'lambdas' do 
      it 'works' do
        r = []
        lbda = ->((e1, e2)){ r << [e1, e2] }
        Dir.files %w{hello world}, lbda  
        expect( r ).to eq expected
      end
    end # context 'lambdas'

    context 'messages' do
      it 'that works too' do
        r = Dir.files %w{hello world}, :reverse
        expect( r ).to eq expected.map(&:reverse)
      end
    end # context 'messages'

  end # context ".file with callables "
end
# SPDX-License-Identifier: Apache-2.0
