# lab42\_core

## Behave

### B for Behave (Well?)

First of all we do not want to impose this code for someone who wants to use the less sophisticated features
of `lab42_core` only. 

Thus we need to require this explicitely:

```ruby
    require 'lab42/core/b'      # or
    require 'lab42/core/behave' # for the chatty ones
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
    [*0..9].my_map(B(:+, 2)).assert == [*2..11]
```

### Is this fn/fm stuff related?

You guess it is, or if you do not want to take guesses, you just believe me it is.
Why should you believe me? Well you should not, you should only believe your eyes!

So let my show:

```ruby
    require 'lab42/core/fn'
    inc2    = Fixnum.fm.+ 2
    doubler = 2.fn.*
    dec     = B(:-, 1)

    (inc2 + doubler + dec).(1).assert == 5
```

