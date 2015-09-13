# lab42\_core

## Behave

### B for Behave (Well?)

First of all we do not want to impose this code for someone who wants to use the less sophisticated features
of `lab42_core` only. 

Thus we need to require this explicitly:

```ruby
    require 'lab42/core/fn'
```

It can be used as with the `#to_proc` kludge, which is a syntactic necessity unless someone
write _Behavior Aware Code_ ;). 

But the main idea is to write _Behavior Aware Code_ BAC(TM).

Example:

```ruby
    # BAC:
    class ::Array
      def my_map beh
        map(&beh)
      end
    end
```

Now use it Luke!

```ruby
    require 'lab42/core/b'
    [*0..9].my_map(B(:+, 2)).assert == [*2..11]
```

### The Difference with fn/fm

The subtle difference can be made clear with an example

```ruby
    adder = B( :+ )
    # can be used for Fixnums
    adder.(1,41) # --> 42
    # or Arrays
    adder.(%w/a b/, %w&c d&) #--> %w%a b c d%
```

While `Fixnum.fm.+` cannot do that

```ruby
    TypeError.assert.raised? do
      Fixnum.fm.+.( [], [] )
    end
```

### Some Behavior

#### Negation

```ruby
  odd = Fixnum.fm.even?.negated
  odd.(1).assert == true 
  odd.(2).assert == false
```

The following is available thanx to the aforeused:

```ruby
    require 'lab42/core/b'
```

#### Identity

```ruby
    Identity.(42).assert == 42
```


