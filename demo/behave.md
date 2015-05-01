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
