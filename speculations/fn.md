# lab42\_core

## Fn/Fm A Functional Approach

As this is a little bit more involved than the rest we need to require this function explicitely

```ruby :include
    require 'lab42/core/fn'
```

### Fn: Functions

Or, in the strange patois of OO languages _methods_.

Example:

```ruby :example
    answer = 41.fn.succ
    expect(answer.()).to eq(42)
```

There are of course different methods (pun intended) to skin this cat:

```ruby :example
    answer = 40.fn.+
    expect(answer.(2)).to eq(42)
```

Or, with early binding, arriving at the same, unevitable, conclusion:

```ruby :example
    answer = 39.fn.+ 3
    expect(answer.()).to eq(42)
```

### Fm: Instance Methods (called fumctions -- just kiddding)

This makes only sense for instances of the class `Module`.

Same as above but now:


```ruby :example
    answer = Integer.fm.+
    expect(answer.(38, 4)).to eq(42)

    # And the usual variations
    answer = Integer.fm.+ 37
    expect(answer.(5)).to eq(42)

    # ...
    answer = Integer.fm.+ 36, 6
    expect(answer.()).to eq(42)
```

Even error behavior is conserved

```ruby :example
    answer = Integer.fm.+
    expect{ answer.(1, 2, 3) }.to raise_error(ArgumentError) 
```

### Earyly vs. Late Binding


There is only one thing to remember: **LIFO**, late superseeds early...

```ruby :example
    answer = Integer.fm.- 1
    expect(answer.(43)).to eq(42)
```

The same is true for _blocks_

```ruby :include
    let(:merger) {{a: 1, b: 2}.fn.merge{ |key, old, new| old + new }}
```

```ruby :example

    expect(merger.( a: 2, c: 3 )).to eq({ a: 3, b: 2, c: 3 })
```

Meaning that we can superseed the early provided block by a differnt one:

```ruby :example
    expect(merger
      .( a: 2, c: 3 ){ |_, o, n| [o, n] })
      .to eq({ a: [1, 2], b: 2, c: 3 })
```

And, attention for head explosions here, even with rebound blocks:

Let us say we define a _Mapper_ as follows

```ruby :include
    let(:mapper) { Array.fm.map }
```

Hey, we can now map anything, anyhow....

Of course it might be useful to have an incrementer

```ruby :include
    let(:incrementer) { Array.fm.map(&:succ) }
```
```ruby :example 
    expect([[0],[1,2]].map(&incrementer)).to eq([ [1],[2,3] ])
```

Well naming things is nice, most of the time, but as an accomplished functional
currying and partial application expert you read code like the following in your sleep

```ruby :example
    expect([[0,1]].map(&mapper._(&:succ))).to eq([[1,2]])
```

And what about this one?

```ruby :example
    general_reducer = Enumerable.fm.inject
    summer          = general_reducer._(&:+)
    # Now that was baaaad, let us try again:
    summer          = general_reducer._(&Integer.fm.+) # Much hotter, OMG I am sooo funny

    one_two         = [[1, 2]]

    expect(one_two.map(&summer)).to eq([3])
    expect(one_two.map(&summer._(10))).to eq([13])

    # Or being general - got a promotion? - again:
    expect(one_two.map(&general_reducer._(10,&Integer.fm.-))).to eq([7])
```


### Functional Rebinding


### Implementation Details

```ruby :example
    Integer.fm.-.tap do | minus |
      expect(minus).to be_kind_of Lab42::Behavior::UnboundBehavior
      expect(minus.to_proc).to be_kind_of Proc
    end

    43.fn.+.tap do | plus |
      expect(plus).to be_kind_of Lab42::Behavior::BoundBehavior
    end
```
