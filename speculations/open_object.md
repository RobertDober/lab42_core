# Open Object

Immutable OpenStruct like objects, implementing `Enumerable` and other goodies.


## Open Struct like behavior

```ruby :example OpenObject

  x = OpenObject.new a: 42
  expect(x.a).to   eq(42)
  expect(x[:a]).to eq(42)
```

## Immutability

All _modifications_ just return a new instance.

```ruby :example Immutability
  x = OpenObject.new a: 42, b: 43

  y = x.update a: 44
  expect(y.to_hash).to eq({a: 44, b: 43})
  expect(x.a).to       eq(42)
```

## Merging

As `OpenObject` is an immutable class, merging becomes a real important aspect. We want to merge all parameters 
according to the `#to_hash` protocol.

```ruby :include
    require 'ostruct'
    let(:a) {OpenObject.new a: 42, c: 44}
    let(:b) {OpenObject.new a: 41, b: 42}
    let(:c) {{a: 40, b: 41, c: 42}}
```

```ruby :example Merging

    ab = OpenObject.merging(a , b)
    expect(ab).to be_kind_of(OpenObject)
    expect(ab.to_hash).to eq(a:41, b:42, c:44)
    
    abc = OpenObject.merging(a, b, c, a)
    expect(abc.to_hash).to eq(a: 42, b: 41, c:44)
```

And of course all concerned objects are immutable:

```ruby :example Still immutable
    expect(a.to_hash).to eq(a:42, c:44)
    expect(b.to_hash).to eq(a:41, b:42)
```


## Relationship with hashes

```ruby :example Hush Hash
    h = { a: 1, b: 2 }
    o = h.to_open_object
    expect(o.to_hash).to eq(h)
```


## Enumerable

### What shall each yield?

Obviously not the same as `.to\_hash.each` would yield. So it yields `OpenObject` instances of size 1

```ruby :example My Own Shiny Iterator
  o = OpenObject.new( a: 42 )
  expect(o.enum_for(:each).to_a).to eq([o])
```
