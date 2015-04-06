# lab42\_core

## Fn/Fm A Functional Approach

As this is a little bit more involved than the rest we need to require this function explicitely

```ruby
    require 'lab42/core/fn'
```

### Fn: Functions

Or, in the strange language of OO languages _methods_.

Example:

```ruby
    answer = 41.fn.inc
    answer.().assert == 42
```

There are of course different methods (pun intended) to skin this cat:

```ruby
    answer = 40.fn.+
    answer.(2).assert == 42
```

Or, with early binding, arriving at the same, unevitable, conclusion:

```ruby
    answer = 39.fn.+ 3
    answer.().assert == 42
```

### Fm: Instance Methods (called fumctions -- just kiddding)

This makes only sense for instances of the class `Module`.

Same as above but now:


```ruby
    answer = Fixnum.fm.+
    answer.(38, 4).assert == 42

    # And the usual variations
    answer = Fixnum.fm.+ 37
    answer.(37, 5).assert == 42

    # ...
    answer = Fixnum.fm.+ 36, 6
    answer.().assert == 42
```

Even error behavior is conserved

```ruby
    answer = Fixnum.fm.+
    ArgumentError.assert.raised? do
      answer.(1, 2, 3)
    end
```

### Earyly vs. Late Binding

In this version there is no choice, late bound parameters **preceed** early bound params.

```ruby
    answer = Fixnum.fm.- 1
    answer.(43).assert == 42
```

The same is true for _blocks_

```ruby
    merger = {a: 1, b: 2}.fn.merge{ |key, old, new| old + new }

    merger.( a: 2, c: 3 ).assert == { a: 3, b: 2, c: 3 }
```

Meaning that we can superseed the early provided block by a differnt one:

```ruby
    merger
      .( a: 2, c: 3 ){ |_, o, n| [o, n] }
      .assert == { a: [1, 2], b: 2, c: 3 }
```
And, attention for head explosions here, even with rebound blocks:

Let us say we define a _Mapper_ as follows

```ruby
    mapper = Array.fm.map
```

Hey, we can now map anything, anyhow....

Of course it might be useful to have an incrementer

```ruby
    incrementer = Array.fm.map(&:succ)

    [1,2].map(&incrementer).assert == [2,3]
```

Well naming things is nice, most of the time, but as an accomplished functional
currying and partial application expert you read code like the following in your sleep

```ruby
    [0,1].map(&mapper._(&:succ)).assert == [1,2]
```

That gets us to the general concept of

### Functional Rebinding


### Implementation Details

```ruby
    Fixnum.fm.-.tap do | minus |
      minus.assert.kind_of? Lab42::Behavior
      minus.to_proc.assert.kind_of? Proc
      minus.arity.assert == 2
    end

    43.fn.+.tap do | plus |
      plus.assert.kind_of? Lab42::Behavior
      plus.arity.assert == 1
    end
```

