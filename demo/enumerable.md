
# lab42\_core

## Enumerable

### grep2

Partitioning with the `===` method can be done with `grep2` as filtering with the `===` method
can be done with `grep` 

```ruby
    # enum.grep2 expr # ===>
    # enum.partition{ |ele| expr === ele }
    %w{ alpha beta alfa romeo alpha centauri }
      .grep2( %r{\Aa.*a\z} ).assert == [
      %w{ alpha alfa alpha },
      %w{ beta romeo centauri }
    ]
```

`Enumerator::Lazy` instances are partitioned into `Enumerator::Lazy` instances.

```ruby
    e = ('a'..'e').to_enum.lazy
    vowels, consonantes = e.grep2 %r{[ae]}

    vowels.assert.kind_of? Enumerator::Lazy
    consonantes.assert.kind_of? Enumerator::Lazy

    vowels.next.assert == 'a'
    vowels.next.assert == 'e'
    StopIteration.assert.raised? do
      vowels.next
    end
    consonantes.to_a.assert == %w{b c d}
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
