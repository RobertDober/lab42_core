# lab42\_core

## Functors

### Why all the fuss where arguments go at runtime?

Yeah, why?

However if we want to make an abstraction of this we need to make one **little** adjustment to our mental setup:

**No more methods**

We will continue to use and write methods, but we will completely forget about them when abstracting on them. This is a pleonasm by the way, right?
Abstraction's purpose is to forget what is abstracted from.

We will name this abstraction, appropriately I hope, a **Functor**.

All we need to know now, is how to use it.

### F, the Functor Factory


```ruby
    sub10 = F.- __, 10 # will just substract 10 from a runtime argument
    sub10.( 52 ).assert == 42
    # And we just cannot call it with too many arguments
    ArgumentError.assert.raised? do
      sub10.( 42, 10 )
    end 
```

of course we can ommit `__` at the end, as arity is checked upon calltime.


```ruby
    subfrom = F.-
    subfrom.(43, 1).assert == 42
```

And if you do not like the `__` place holder you might already have found out in your console or debugger
that it is nothing more or less, than the Functor Factory `F` itself, so you can rewrite the example from
above as follows:

```ruby
    sub10 = F.- F, 10 # will just substract 10 from a runtime argument
    sub10.( 52 ).assert == 42

```

not surprisingly we find our **Method Abstratcions** here, same principle.

```ruby
    subfrom = Fixnum.fm.-
```
