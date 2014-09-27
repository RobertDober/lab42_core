
# lab42\_core

## Enumerable

### grep2

```ruby
    # enum.grep2 expr # ===>
    # enum.partition{ |ele| expr === ele }
    %w{ alpha beta alfa romeo alpha centauri }
      .grep2( %r{\Aa.*a\z} ).assert == [
      %w{ alpha alfa alpha },
      %w{ beta romeo centauri }
    ]
```

### to\_proc

And also `Enumerable#to\_proc` as e.g.

```ruby
    counter = (1..3).to_proc
    counter.().assert == 1
    counter.().assert == 2
    counter.().assert == 3
    StopIteration.assert.raised? do
      counter.()
    end
```

### flatten\_once

```ruby
    [{a: 1}, [[{b: 2},[3]]]]
      .flatten_once
      .assert == [{a: 1}, [{b: 2}, [3]]]
```



