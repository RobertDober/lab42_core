# Open Object

Immutable OpenStruct like objects, implementing `Enumerable` and other goodies.


## Open Struct like behavior

```ruby

  x = OpenObject.new a: 42
  x.a.assert   == 42
  x[:a].assert == 42
```

## Immutability

If you want to get rid of the namespace, you can require `lab42/open_object` instead of
`lab42/core/open_object`.

All _modifications_ just return a new instance.

```ruby
  x = OpenObject.new a: 42, b: 43

  y = x.update a: 44
  y.to_hash.assert == {a: 44, b: 43}
  x.a.assert       ==  42
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
