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
    module ::Enumerable
      def bmap beh
        map(&beh)
      end
    end
```

Now use it Luke!

```ruby
    [*0..9].bmap(B(:+, 2)).assert == [*2..11]
```

#### When do we call What?

##### The classic _send message_ case

```ruby
    (0..9).bmap(B(:succ)).assert == [*1..10]
    # meaning...
    B(:succ).(41).assert == 42
```

... which can have curried parameters of course

```ruby
    B(:+, 1).(41).assert == 42
```

##### But what if we want the receiver to become an argument?

Some jargon might come in handy:

```ruby
    B(43, :-).(1).assert == 42
    #  ^       ^
    #  |       |
    #  |       +--------------  late arguments (or runtime arguments)
    #  |        
    #  +----------------------  early arguments (or compile time arguments)       
```

This means, that for `B` a symbol at first means _send message__ to first _late argument_, and anything
else means, _send message_ to first _early argument_.



