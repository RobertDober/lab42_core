# lab42\_core

## Functors

First of all we do not want to impose this code for someone who wants to use the less sophisticated features
of `lab42_core` only. 

Thus we need to require this explicitely:

```ruby
    require 'lab42/core/functor'
```

### So what is this?

Theoretically the `Functor` is a *composable* Abstraction of Behavior, whre Behavior stands for
whatever can be called, *proc*, *bound methods* or whenever `#call` is defined.

Hence it's motto: Whenever you can call it, it should be a **Functor** !  

### Great and how do I get it?

In theory, my dear Data, you could just invoke `Lab42::Functor.new` ...

but use the factories, Luke, use the factories.


There can be only one, I did not like this movie, so we will see that the statement starting this line is false.

`F` 

scan F for behavior:

```ruby
    F.+  # a functor
    (1..10).reduce(&F.+).assert == 55
```

#### Creation Time vs. Invocation Time

As arguments can be passed in at _Creation Time_ (CT) and _Invocation Time_ (IT) we want to
distinguish them accordingly.

```ruby
    F.-( 43 ).(1).assert == 42
    #  ^       ^
    #  |       |
    #  |       +--------------  IT arguments
    #  |        
    #  +----------------------  CT arguments
```

Astute observers of the universe, talking about the same Lt. Cdr. again, will observe that
the `F` factory does not work so well with some _standard_ Ruby applications.

```ruby
    (10..12).map(&F.-(1)).assert == [ -9, -10, -11 ] # oops, probably not what you want
```

Placeholders to the resque. 

```ruby
    (10..12).map(&F.-(F,1)).assert == [*9..11]
```

#### A Very Common Case

and therefore we have a second factory, called `M`, because I could not come up with any good
reason to call it `Q` :(.

```ruby
    (10..12).map(&M.-(1)).assert == [*9..11]
    # which is, of course
    (10..12).map(&M.pred).assert == [*9..11]
    # which is, of course
    (10..12).map(&F.pred).assert == [*9..11]
```

Not very useful so far, but what about that?

```ruby
    dramatis_personae = \
      [{name: 'Data', grade: 'Lt. Cmd'},
       {name: 'Picard', grade: 'Cpt'},
       {name: 'Q', grade: 'A Q'}]

    select_name = M.map( &M[:name] )
    select_name.( dramatis_personae ).assert == %w{Data Picard Q}
```

### Functional Composition

and to go beyond

```ruby
    name_size = M[:name] + M.size
    select_name_size = M.map( &name_size )
  
    select_name_size.( dramatis_personae ).assert == [4, 6, 1]
```

#### Pipelines

Pipelines are nice semantic sugar for much more readable functional composition

```ruby
    P( dramatis_personae, select_name, F.size ).assert == [4, 6, 1]
```

If `#|` is not defined on your initial value this syntax can be used too:


```ruby
    (dramatis_personae | select_name | F.size ).assert == [4 | 6 | 1]
```




#### Demonstrating the code from the README


```ruby
    F.-( F, 10 ).(52).assert == 42 # F is used as a place holder too
    # and
    M.-( 10 ).( 52 ).assert == 42
```
