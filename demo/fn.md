# lab42\_core

## Fn/Fm A Functional Approach

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

