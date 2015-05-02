# lab42\_core


[![Build Status](https://travis-ci.org/RobertDober/lab42_core.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_core)
[![Code Climate](https://codeclimate.com/github/RobertDober/lab42_core/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_core)
[![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_core/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_core)
[![Gem Version](https://badge.fury.io/rb/lab42_core.svg)](http://badge.fury.io/rb/lab42_core)

Simple Ruby Core Module Extensions (for more see lab42\_more)

## Programming Paradigms

### Functional

#### Fn/Fm - Functional Access To Methods

Can be used after `require 'lab42/core/fn'` **only**.

Might be moved into gem [lab42\_more](https://github.com/RobertDober/lab42_more) in the future .

API will remain the same, require will change to `require 'lab42_more/fn'` 

##### fn like function

```ruby
    Dir.files [APP_ROOT, 'spec', 'support', '**', '*.rb'], Kernel.fn.require

    Dir.files( %w{.. assets ** *.txt} ).sort_by &File.fn.mtime
```
  
##### fm like function/method

```ruby
    %w{ alpha beta gamma delta }.sort_by &String.fm.size
```

**N.B.** This only works because the object behind the scenes of `Class#fm` knows how to bind
upon call, once it has been transformed by `#to_proc` 


For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/fn.md).

## Functors

We exposed methods as _functions_ in the previous chapter. However we are subject to sematic confusion
with terms like _methods_, _procedures_, _lambdas_ and _functions_. 

Is it not time to abstract a little bit?

Enter **Functors**

Whenever you can call it, it should be a **Functor** !

There are two main namespace factories for functors - available upon `require 'lab42/core/functor'` 

`F`, the truley functional way, and `M` the truely methodical way. As a matter of fact the latter is just a convenience factory for the former:

```ruby
    F.-( F, 10 ).(52).assert == 42 # F is used as a place holder too
    # and
    M.-( 10 ).( 52 ).assert == 42
```


For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/functors.md).

#### Memoization and Lazy Attributes

##### Memoization

is a, slightly forgotten, programming technique protecting against double calcultions.

This became extremly useful with [Dynamic Programming](https://en.wikipedia.org/wiki/Dynamic_programming#Dijkstra.27s_algorithm_for_the_shortest_path_problem) .

A much more simle example is allowing us to express and implement the [Fibonacci Sequence](https://en.wikipedia.org/wiki/Dynamic_programming#Fibonacci_sequence) in the same, some might say naïve, way.

Compared to the explicit memoization as shown in the Wikipedia article, which would read as follows in Ruby

```ruby
  def fibo n, cache=[0, 1]
    return cache[n] if cache[n]
    cache[n] = fibo( n.pred, cache ) + fibo( n.pred.pred, cache )
  end
```

It is still amazing how the specialized cache initialisation allows us to get rid of the original if statement.

However the general case would read like this

```ruby
    def f n, cache = {}
      args_hash = some_hash_fn n  # n is all args here 
      return cache[args_hash] if cache[args_hash]
      cache[args_hash] = f_implemenetation( some_fn(n), cache )
    end
```

While a memoization mechanisme built into the language allos to write things like

```ruby
    def_memoized f *args
      ...
    end

    def f *args
      ...
    end
    memoize :f

    # Which can be written as
    memoize \
      def f *args
        ...
      end

   memoized do
     def f *args
       ...
     end
   end
```

This gem opts for the `memoize` method in the `Module` class as this allows for
two different syntaxes

```ruby
    memoize def f ...
    end

    #
    def f ...
    end
    memoize :f
    
```

##### Lazy Attributes

Are just parameterless memoized methods, excatly the same as `let` bindings in [RSpec](http://www.rubydoc.info/gems/rspec-core/RSpec/Core/MemoizedHelpers/ClassMethods#let-instance_method).

```ruby
    lazy_attr( :config ){ YAML.read config_file }
```

One could say they are just syntactic sugar for

```ruby
    memoize def config
      YAML.read config_file
    end
```

One would be correct, but lazy attributes are many (in some of my modules and classes) and have a semantic role often very similar to
the example above. They are by nature static while methods like the shortest path or fibonacci are highly dynamic.

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/memoization.md).

##### Gotchas

Do not, I repeat, **Do not** memoize methods with side effects!

The exception is _cached reading_ as in the example above.

Do not call memoized methods with arguments that cannot be used as Hash keys like e.g. BasicObject instances or other objects not responding to the **original** `hash` method.

## Core Extensions

### Array

Can be used after `require 'lab42/core'` or `require 'lab42/core/array'`  

#### #flatten\_once

```ruby
    [].flatten_once.assert.empty?

    [[2, {a: 3}, [4]], {a: 5}].flatten_once.assert ==
      [2, {a: 3}, [4], {a: 5}]
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/array.md).

### Dir

Can be used after `require 'lab42/core'` or `require 'lab42/core/dir'`  

```ruby
  Dir.files "**/*" do | partial_path, full_path |
  end
```

If only the relative or absolute pathes are needed there are the two variations avaiable:

```ruby
    Dir.abs_files ...
    Dir.rel_files ...
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/dir.md).

### Enumerable

#### grep2

```ruby
  enum.grep2 expr # ===>
  enum.partition{ |ele| expr === ele }
```

#### to\_proc

And also `Enumerable#to\_proc` as e.g.

```ruby
    counter = (1..3).to_proc
    counter.().assert == 1
    counter.().assert == 2
    counter.().assert == 3
    StopIteration.assert.raised? do
      counter.()
    end
```


For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/enumerable.md).

### File

#### #expand_local_path

`expand_local_path` to get rid of the `__FILE__` inside `expand_path`.

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/file.md).

#### #if_readable

```ruby
    File.if_readable 'some_file' do | file |  # openes file as readable
      
    end
```


#### #if_writeable

### Hash

#### #only

```ruby
  {a: 42, b: 43}.only :a, :c # ===> {a: 42}
```

#### #fetch! (read fetch and set)

```ruby
    a = {a: 42}
    a.fetch!(b, 43) # or a.fetch!(b){43}
    a == {a: 42, b: 43 } # true
```

**N.B.** Unlike `Hash#fetch` `Hash#fetch!` will **not** warn you that the block superseeds the default arg if both
are provided (after all there is a !).

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/hash.md).


### Object

Backport of `#itself` for versions < 2.2

### OpenObject

Immutable Open Objects

```ruby
  x = OpenObject.new a: 42
  x.a.assert   == 42
  x[:a].assert == 42
```

Immutability


All _modifications_ just return a new instance.

```ruby
  x = OpenObject.new a: 42, b: 43

  y = x.update a: 44
  y.to_hash.assert == {a: 44, b: 43}
  x.a.assert       ==  42
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/open_object.md).

## Tools

### Console Tools


Can be used **only** after 'lab42/core/console_tools'.`

**N.B.** Never use in production code or applications. This code is extremly oriented console monkeypatching core classes massively.

This part is documented in [QED Console Tools](https://github.com/RobertDober/lab42_core/blob/master/demo/console_tools.md).
