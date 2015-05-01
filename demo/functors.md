# lab42\_core

## Functors

### Why all the fuss where arguments go at runtime?

Yeah, why?

However if we want to make an abstraction of this we need to make one **little** adjustment to our mental setup:

**No more methods**

We will continue to use and write methods, but we will completely forget about them when abstracting on them.

```ruby
    sub10 = F(:-, __, 10) # will just substract 10 from a runtime argument
    sub10.( 52 ).assert == 42
    # And we just cannot call it with too many arguments
    ArgumentError.assert.raised? do
      sub10.( 42, 10 )
    end 
```

of course we can ommit `__` at the end, as arity is checked upon calltime.

