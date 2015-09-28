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

A misnamer, should have been called `select_by_value`

```ruby
    h = {a: nil, b: 42, c: false}
    h.select_values(:itself).assert == {b: 42}

    {a: 1, b: 2, c: 4}.select_values(&:odd?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.select_values(:odd?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.select_values(:<, 2).assert == {a: 1}
    {a: 1, b: 2, c: 4}.select_values{ |v| v < 2 }.assert == {a: 1}
```

### reject_values

A misnamer, should have been called `reject_by_value`

```ruby
    h = {a: nil, b: 42, c: false}
    h.reject_values(:itself).assert == {a: nil, c: false}

    {a: 1, b: 2, c: 4}.reject_values(&:even?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.reject_values(:even?).assert == {a: 1}
    {a: 1, b: 2, c: 4}.reject_values(:>, 1).assert == {a: 1}
    {a: 1, b: 2, c: 4}.reject_values{ |v| v > 1 }.assert == {a: 1}
```

### merge_rec

Recursive Replacement

#### Original Object untouched of course

```ruby

    a = {a: 42, x: {a: 43}}
    b = a.merge_rec( :a, &:succ )
    a.assert == {a: 42, x: {a: 43}}
    b.assert == {a: 43, x: {a: 44}}
    
```

#### Bulk replacements

```ruby
    a = {1 => 42, 2 => 43, :x => { 1 => 44 }} 
    b = a.merge_rec( 1, 2, &:succ )
    b.assert == { 1 => 43, 2 => 44, :x => { 1 => 45 } }
``` 

Keys are passed into the block
```ruby
    a = {1 => 42, 2 => 43, :x => { 1 => 44 }} 
    b = a.merge_rec( 1, 2 ){ |val, key| 2*val + key }
    b.assert == { 1 => 85, 2 => 88, :x => { 1 => 89 } }
``` 

#### Limits

```ruby
    a = {a: 1, x: {a: 2, x:{a: 3}}}
    a.merge_rec( :a, limit: 2, &:pred ).
      assert == {a: 0, x: {a: 1, x:{a: 3}}}
    
``` 

Limits can be chosen per key

```ruby
    a = {a: 1, b: 10, x: {a: 2, x:{a: 3, b: 20}}}
    a.merge_rec( :a, :b, limits: {b: 1}, &:pred ).
      assert == {a: 0, b: 9, x: {a: 1, x:{a: 2, b: 20}}}
    
``` 
### without

```ruby
    h = {a: 1, b: 2, c: 3}
  
    h.without( :b, :c, :d ).assert == {a: 1}
    h.assert == {a: 1, b: 2, c: 3}
```

