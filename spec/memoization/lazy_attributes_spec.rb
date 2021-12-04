require 'spec_helper'

describe Module do 

  context 'lazy attributes work like attributes with initial values' do 

    shared_examples_for "knowing the answer" do
      it "which is 42" do
        expect( subject.answer ).to eq 42
      end
    end

    context 'for instances' do 
      let( :k ) do
        Class.new do
          lazy_attr( :answer ){ 42 }
        end
      end
      let( :subject ){ k.new }

      it_behaves_like "knowing the answer"
    end # context 'lazy attributes work like attributes with initial values'

    context 'for extended objects' do 
      let( :m ) do
        Module.new do
          lazy_attr( :answer ){ 42 }
        end
      end
      let( :subject ){ Object.new.extend m }

      it_behaves_like "knowing the answer"
    end # context 'lazy attributes work like attributes with initial values'

  end # context 'lazy attributes work like attributes with initial values'
end # describe Module
# SPDX-License-Identifier: Apache-2.0
