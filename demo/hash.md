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

### fetch!

```ruby
    a = {}
    a.fetch!(:a, 42)
    a.fetch!(:b){ 43 }
    a.assert == {a: 42, b: 43}
```

### select_values

```ruby
    h = {a: nil, b: 42, c: false}
    h.select_values(:itself).assert == {b: 42}

    {a: 1, b: 2, c: 4}.select_values(&:odd?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.select_values(:odd?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.select_values(:<, 2).assert == {a: 1}
    {a: 1, b: 2, c: 4}.select_values{ |v| v < 2 }.assert == {a: 1}
```

### reject_values

```ruby
    h = {a: nil, b: 42, c: false}
    h.reject_values(:itself).assert == {a: nil, c: false}

    {a: 1, b: 2, c: 4}.reject_values(&:even?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.reject_values(:even?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.reject_values(:>, 1).assert == {a: 1}
    {a: 1, b: 2, c: 4}.reject_values{ |v| v > 1 }.assert == {a: 1}
    
```

### without

```ruby
    h = {a: 1, b: 2, c: 3}
  
    h.without( :b, :c, :d ).assert == {a: 1}
    h.assert == {a: 1, b: 2, c: 3}
```

