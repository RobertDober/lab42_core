# Open Object

Immutable OpenStruct like objects, implementing `Enumerable` and other goodies.


## Open Struct like behavior

```ruby
  OpenObject = Lab42::Core::OpenObject

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

## Enumerable

### What shall each yield?

Obviously not the same as `.to_hash.each` would yield. So it yields `OpenObject` instances of size 1

```ruby
  o = OpenObject.new( a: 42 )
  o.map(:self).assert == [o]
```

### Transformations

Map does what `each` dictates of course. But there are many use cases for transformations  from one
OpenObject instance into another. Mostly by applying functions to values, sometimes to values and keys
and sometimes to keys alone.


```ruby
    o = OpenObject.new a: 42, b: 44, c: 46

    o.transform_values{|x| x / 2 }.assert == OpenObject.new( a: 21, b: 22, c: 23 )
```
