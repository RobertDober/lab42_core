
# lab42\_core

## Enumerable

### grep2

Partitioning with the `===` method can be done with `grep2` as filtering with the `===` method
can be done with `grep` 

```ruby :example
    # enum.grep2 expr # ===>
    # enum.partition{ |ele| expr === ele }
    expect(%w{ alpha beta alfa romeo alpha centauri }
      .grep2( %r{\Aa.*a\z} ))
      .to eq([
      %w{ alpha alfa alpha },
      %w{ beta romeo centauri }])
```

`Enumerator::Lazy` instances are partitioned into `Enumerator::Lazy` instances.

```ruby :example
    e = ('a'..'e').to_enum.lazy
    vowels, consonantes = e.grep2 %r{[ae]}

    expect(vowels).to be_kind_of(Enumerator::Lazy)
    expect(consonantes).to be_kind_of(Enumerator::Lazy)

    expect(vowels.next).to eq('a')
    expect(vowels.next).to eq('e')
    expect{ vowels.next }.to raise_error(StopIteration)
    expect(consonantes.to_a).to eq(%w{b c d})
```


### to\_proc

#### For Enumerables and Friends

And also `Enumerable#to\_proc` as e.g.

```ruby :example
    counter = (1..3).to_proc
    expect(counter.()).to eq(1)
    expect(counter.()).to eq(2)
    expect(counter.()).to eq(3)
    expect{ counter.() }.to raise_error(StopIteration)
```
