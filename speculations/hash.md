# lab42\_core

## Hash

### only

```ruby :example
    expect({a: 1, b: 2}.only( :a, :c ))
      .to eq(a: 1)
```


#### with_present

This is the orthogonal behavior of `fetch's` block form.

```ruby :example
    result = {a: 1}.with_present( :a )do |v|
       v + 41
    end
    expect( result ).to eq(42)
```

But nothing might happen if there is no key

```ruby :example
    {a: 1}.with_present :no_key do
      raise RuntimeError, "no worries this can't happen"
    end
```


#### with_present convenience param

```ruby :example
    result = {a: :b, b: 42}.with_present(:a) do |v, h|
      h[v]
    end
    expect( result ).to eq(42)
```

### fetch!

```ruby :example
    a = {}
    a.fetch!(:a, 42)
    a.fetch!(:b){ 43 }
    expect(a).to eq( a: 42, b: 43 )
```

### select_values

A misnamer, should have been called `select_by_value`

```ruby :example
    h = {a: nil, b: 42, c: false}
    expect(h.select_values(:itself)).to eq(b: 42)

    expect({a: 1, b: 2, c: 4}.select_values(&:odd?)).to eq({a: 1})
    expect({a: 1, b: 2, c: 4}.select_values(:odd?)).to eq({a: 1})
    expect({a: 1, b: 2, c: 4}.select_values(:<, 2)).to eq({a: 1})
    expect({a: 1, b: 2, c: 4}.select_values{ |v| v < 2 }).to eq({a: 1})
```

### reject_values

A misnamer, should have been called `reject_by_value`

```ruby :example
    h = {a: nil, b: 42, c: false}
    expect(h.reject_values(:itself)).to eq({a: nil, c: false})
    expect({a: 1, b: 2, c: 4}.reject_values(&:even?)).to eq({a: 1})
    expect({a: 1, b: 2, c: 4}.reject_values(:even?)).to eq({a: 1})
    expect({a: 1, b: 2, c: 4}.reject_values(:>, 1)).to eq(a: 1)
    expect({a: 1, b: 2, c: 4}.reject_values{ |v| v > 1 }).to eq({a: 1})
```

### replace_rec

Recursive Replacement

#### Original Object untouched of course

```ruby :example

    a = {a: 42, x: {a: 43}}
    b = a.replace_rec( :a, &:succ )
    expect(a).to eq({a: 42, x: {a: 43}})
    expect(b).to eq({a: 43, x: {a: 44}})
    
```

#### Bulk replacements

```ruby :example
    a = {1 => 42, 2 => 43, :x => { 1 => 44 }} 
    b = a.replace_rec( 1, 2, &:succ )
    expect(b).to eq(1 => 43, 2 => 44, :x => { 1 => 45 })
``` 

Keys are passed into the block
```ruby :example
    a = {1 => 42, 2 => 43, :x => { 1 => 44 }} 
    b = a.replace_rec( 1, 2 ){ |val, key| 2*val + key }
    expect(b).to eq(1 => 85, 2 => 88, :x => { 1 => 89 })
``` 

#### Limits

```ruby :example
    a = {a: 1, x: {a: 2, x:{a: 3}}}
    expect(a.replace_rec( :a, limit: 2, &:pred ))
      .to eq(a: 0, x: {a: 1, x:{a: 3}})
    
``` 

Limits can be chosen per key

```ruby :example
    a = {a: 1, b: 10, x: {a: 2, x:{a: 3, b: 20}}}
    expect(a.replace_rec( :a, :b, limits: {b: 1}, &:pred ))
      .to eq(a: 0, b: 9, x: {a: 1, x:{a: 2, b: 20}})
    
``` 

#### Endless recursion is avoided

Simply by not recursing into replaced chunks of the hash

```ruby :example
      subhashes = { a: 1, x: { a: 2 } }
      repl = ->{{a: 100}}
      expect(subhashes.replace_rec(:a, &repl)).to eq(a: {a: 100}, x: { a: {a: 100}})
```

### without

```ruby :example
    h = {a: 1, b: 2, c: 3}
  
    expect(h.without( :b, :c, :d )).to eq( a: 1 )
    expect(h).to eq(a: 1, b: 2, c: 3)
```
