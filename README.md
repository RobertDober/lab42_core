# lab42\_core

Ruby Core Module Extensions (in the spirit of lab419/core)

## Motivation

This Ruby extension library tries to ease the developper's work by means of two fundamental
concepts.

### Concepts

* Extension of Behavior

* Unification of Behavior

This is achieved by a conventional argument API on top of Ruby's core API, and is highly
opinnionated.

### Opinions

#### The Symbol#to_proc kludge is a crime.

As useful as it is it has two shortcomings and I cannot find any viewpoint that allows
me to not see at least one of these two.
Either I adhere to the point of view, that it cannot be the responsability of `Symbol`
to transform itself to a method. Or if I could I would need to point out that it does
it very badly. Here is my cannonical example for that point.

```ruby
  (1..10).filter( &:even? )
  # and how can I do this?
  (1..10).filter( &:>, 10 )???
```

I could not even come up with a & based notation that would parse...

As YHS is very heavily influenced by functional style it might not come as a surprise
that he thinks that the responsibility to convert a symbol to behavior, is to be with
the behavior consumer.
Of course there are countless behavior consumers, as a matter of fact one could call
them Higher Order Methods, and it would be impractical not to provide one single point
of responsability for that behavior provision. But by freeing `Symbol` from this 
responsibility we can accomplish much more in a single, dedicated place.


This dedicated place, which is automatically loaded if you require `lab42/core` does
however not introduce the API methods into `Kernel`. If you want that to happen, you
need to require `lab42/core/kernel` so that it is up to you, if you want the `Kernel`
namespace polluted or not.

This too is a guiding principle of this gem. Require `lab42/core` and get the `Lab42`
namespace filled up with everything available. Require anything in particular to get
only part of it and / or monkey patches for `Kernel`, `Enumerable` and their friends.

#### Enumerables Need a Unified API

And this goes beyond passing the `Symbol#to_proc` kludge. Therefore one can count on
the `Behavior` based implementation of the API.

# The API

## Behavior


## Dir


```ruby
  require 'lab42/core/dir'
  Dir.files "**/*" do | partial_path, full_path |
  end
```

## Enumerable

```ruby
  require 'lab42/core/enumerable'

  enum.grep2 expr # ===>
  enum.partition{ |ele| expr === ele }
  # But for non behavior parameters ...
  enum.partition expr
  # the same effect can be achieved by the predicate semantics.
```

## Hash

```ruby
  require 'lab42/core/hash'

  {a: 42, b: 43}.only :a, :c # ===> {a: 42}
```

## Fn

### Access to methods

```ruby
  require 'lab42/core/fn'

  # Get method of an object
  printer = Kernel.fn.puts
  printer.( 42 )   
  2.times(&printer)

  # It also extends some enumerable methods for easier execution
  %w{hello world}.each printer
```

Thusly `fn` gives us access to methods of objects, but what about instance methods?

### Access to instance methods

Is realized via `fm`.

```ruby
  require 'lab42/core/fn'

  (1..100).reduce Fixnum.fm.+ # ---> 5050
```

### Objects as constant procs

While `Object#self` will return the obvious, so will by extension `object.fn.self`.

This can be very useful, e.g. in this nice way to create an empty array ;)

```ruby
  (1..100).filter(false.fn.self)
```

If you hesitate to use this all, have a look into Kernel#const_lambda

### Partial Application

```ruby
  f = Array.fm.push :next
  [[],[1]].map( f ) # ---> [[:next], [1, :next]]

  a=[]
  f = a.fn.push :first
  f.(1) # a ---> [:first, 1]
```

## OpenObject

Immutable Open Objects

They are described in detail [here](dox/OpenObject.md) 
