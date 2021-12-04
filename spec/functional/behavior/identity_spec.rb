require "b_helper"
 
context Lab42::Behavior do 
  it "is identical" do
    expect( Identity.( 42 ) ).to eq 42
  end
end # context Lab42::Behavior
# SPDX-License-Identifier: Apache-2.0
