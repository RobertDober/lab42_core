# lab42\_core

Simple Ruby Core Module Extensions (for more see lab42\_more)

## Dir

```ruby
  Dir.files "**/*" do | partial_path, full_path |
  end
```

## Enumerable

```ruby
  enum.grep2 expr # ===>
  enum.partition{ |ele| expr === ele }
```

## Hash

```ruby
  {a: 42, b: 43}.only :a, :c # ===> {a: 42}
```

## Fn

Must be required specifically!

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
