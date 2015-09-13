# Open Object

Immutable OpenStruct like objects, implementing `Enumerable` and other goodies.


## Open Struct like behavior

```ruby

  x = OpenObject.new a: 42
  x.a.assert   == 42
  x[:a].assert == 42
```

## Immutability

All _modifications_ just return a new instance.

```ruby
  x = OpenObject.new a: 42, b: 43

  y = x.update a: 44
  y.to_hash.assert == {a: 44, b: 43}
  x.a.assert       ==  42
```

## Merging

As `OpenObject` is an immutable class, merging becomes a real important aspect. We want to merge all parameters 
according to the `#to_hash` protocol.

```ruby
    require 'ostruct'
    a = OpenObject.new a: 42, c: 44
    b = OpenObject.new a: 41, b: 42
    c = {a: 40, b: 41, c: 42}

    ab = OpenObject.merging(a , b)
    ab.assert.kind_of? OpenObject
    ab.to_hash.assert == {a:41, b:42, c:44}
    
    abc = OpenObject.merging(a, b, c, a)
    abc.to_hash.assert == {a: 42, b: 41, c:44}
```

And of course all concerned objects are immutable:

```ruby
    a.to_hash.assert == {a:42, c:44}
    b.to_hash.assert == {a:41, b:42} #...
```


## Relationship with hashes

```ruby
    h = { a: 1, b: 2 }
    o = h.to_open_object
    o.to_hash.assert == h

```


## Enumerable

### What shall each yield?

Obviously not the same as `.to\_hash.each` would yield. So it yields `OpenObject` instances of size 1

```ruby
  o = OpenObject.new( a: 42 )
  o.enum_for(:each).to_a.assert == [o]
```
