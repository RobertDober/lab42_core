# lab42\_core

## Hash

### only

```ruby
    {a: 1, b: 2}.only( :a, :c ).assert ==
      {a: 1}
```


#### with_present

This is the orthogonal behavior of `fetch's` block form.

```ruby
    {a: 1}.with_present( :a )do |v|
       v + 41
    end.assert == 42
```

But nothing might happen if there is no key

```ruby
    {a: 1}.with_present :no_key do
      raise RuntimeError, "no worries this can't happen"
    end
```


#### with_present convenience param

```ruby
    {a: :b, b: 42}.with_present(:a) do |v, h|
      h[v]
    end.assert == 42
```




