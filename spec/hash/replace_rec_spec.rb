require 'spec_helper'
require 'lab42/core/fn'

RSpec.describe Hash do
 
  context "#replace_rec" do 
    context "nilpotent if keys are not present" do 
      it "as in empty hashes" do
        expect( {}.replace_rec( :a, &Integer.fm.succ ) ).to be_empty
      end
      it "as in keys are not there" do
        expect( {c: 42}.replace_rec( :a, :b, &Integer.fm.succ ) ).to eq c: 42
      end
    end # context "nilpotent if keys are not present"

    context "behaves like merge" do 
      let( :receiver ){ {a: 1, b: 2} }
      context "with one key it changes that value" do 
        it "in the result" do
          expect( receiver.replace_rec( :a, &Integer.fm.succ ) ).to eq a: 2, b: 2
        end
        it "but not in the receiver" do
          receiver.replace_rec( :a, &Integer.fm.succ )
          expect( receiver ).to eq a: 1, b: 2
        end
      end # context "with one key"
      context "with two keys it changes the values" do 
        it "in the result" do
          expect( receiver.replace_rec( :a, :b, &Integer.fm.succ ) ).to eq a: 2, b: 3
        end
        it "but not in the receiver" do
          receiver.replace_rec( :a, :b, &Integer.fm.succ )
          expect( receiver ).to eq a: 1, b: 2
        end
      end # context "with two keys it changes the values"
    end # context "behaves like merge"

    context "but also works in subhashes" do 
      let( :complex ){ {a: 1, x:{ a: 2, b: 10, x: {a: 3, b: 20}}} }
      it "changes all values of a given key" do
        expect( complex.replace_rec(:a, &:succ) ).to eq a: 2, x:{a: 3, b: 10, x: {a: 4, b: 20} }
      end
      it "changes all values of all given keys" do
        expect( complex.replace_rec(:a, :b, &:succ) ).to eq a: 2, x:{a: 3, b: 11, x: {a: 4, b: 21} }
      end
      it "changes only a certain number of values (for one key)" do
        expect( complex.replace_rec :a, limit: 2, &:succ ).to eq a: 2, x:{a: 3, b: 10, x: {a: 3, b: 20} }
      end
      it "changes only a certain number of values (for some keys)" do
        expect( complex.replace_rec(:a, :b, limit: 1, &:succ) ).to eq a: 2, x:{a: 2, b: 11, x: {a: 3, b: 20} }
      end
      it "can have different limits per key" do
        expect( complex.replace_rec(:a, :b, limits: {a: 2, b: 1}, &:succ ) ).to eq a: 2, x:{ a: 3, b: 11, x: {a: 3, b: 20}}
      end

      it "and all keys do not have to posess defined limits" do
        a = {a: 1, b: 10, x: {a: 2, x:{a: 3, b: 20}}} 
        expect( a.replace_rec( :a, :b, limits: {b: 1}, &:pred )).to eq a: 0, b: 9, x: {a: 1, x:{a: 2, b: 20}}
      end
    end # context "but also works in subhashes"

    context "replace order is outside inside" do 
      let( :subkey ){ {a: 1, x: { a: { a: 2, b: 1 } } } }
      let( :repl ){ ->{{a: 100}} }

      it "therefore cuts a subhash if it has a replacement key" do
        expect( subkey.replace_rec(:a, :b, &repl) ).to eq a: {a: 100}, x: { a: {a: 100}}
      end
      it "unless limits avoid this, in which case we recurse anyway" do
        expect( subkey.replace_rec(:a, :b, limit: 1, &repl) ).to eq a: {a: 100}, x: { a: { a: 2, b: {a: 100}}}
                                                                                     
      end
    end # context "replace order is outside inside"
  end # context "#replace_rec"
end
# SPDX-License-Identifier: Apache-2.0
