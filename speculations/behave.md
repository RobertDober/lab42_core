# lab42\_core

## Behave

### B for Behave (Well?)

First of all we do not want to impose this code for someone who wants to use the less sophisticated features
of `lab42_core` only. 

Thus we need to require this explicitly:

```ruby :include
  require 'lab42/core/fn'
```

It can be used as with the `#to_proc` kludge, which is a syntactic necessity unless someone
write _Behavior Aware Code_ ;). 

But the main idea is to write _Behavior Aware Code_ BAC(TM).


```ruby :include
    # BAC:
    class ::Array
      def my_map beh
        map(&beh)
      end
    end
```

Now use it Luke!

Example: B for behavior

```ruby :example
    require 'lab42/core/b'
    expect([*0..9].my_map(B(:+, 2))).to eq([*2..11])
```

### The Difference with fn/fm

The subtle difference can be made clear with an example

Example: B only cares about behavior, not types

```ruby :example
    adder = B( :+ )
    # can be used for Fixnums
    expect(adder.(1,41)).to eq(42) # --> 42
    # or Arrays
    expect(adder.(%w/a b/, %w&c d&)).to eq(%w%a b c d%)
```

While `Fixnum.fm.+` cannot do that

Example: .fm.+ is type aware
```ruby :example
    expect{ Integer.fm.+.([], []) }
      .to raise_error(TypeError)
```

### Some Behavior

Example: Negation

```ruby :example
  odd = Integer.fm.even?.negated
  expect(odd.(1)).to be_truthy
  expect(odd.(2)).to be_falsy
```

The following is available thanx to the aforeused:

```ruby
    require 'lab42/core/b'
```

Example: Identity

```ruby :example
    expect( Identity.(42) ).to eq(42)
```
