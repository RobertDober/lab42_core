require 'spec_helper'

describe 'OpenObject 1', :spec_me do
  it 'example 1' do
    
    require 'lab42/core/open_object'
    
    x = Lab42::Core::OpenObject.new a: 42
    expect( x.a ).to eq(
      42
    )
    expect( x[:a] ).to eq(
      42
    )
  end
  it 'example 2' do
    require 'lab42/open_object'
    
    x = OpenObject.new a: 42, b: 43
    
    y = x.update a: 44
    expect( y.to_hash ).to eq(
      {a: 44, b: 43}
    )
    expect( x.a ).to eq(
      42
    )
  end
  it 'example 3' do
    o = OpenObject.new( a: 42 )
    expect( o.map(:self) ).to eq(
      [o]
    )
  end
  it 'example 4' do
    o = OpenObject.new a: 42, b: 44, c: 46
    
    expect( o.transform_values{|x| x / 2 } ).to eq(
      OpenObject.new a: 21, b: 22, c: 23
    )
  end
end
