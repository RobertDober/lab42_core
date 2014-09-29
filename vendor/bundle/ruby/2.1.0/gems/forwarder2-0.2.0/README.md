# Forwarder2

This implementation is for, and needs, Ruby 2.
For Ruby 1.9 please see https://github.com/RobertDober/Forwarder19.
For Ruby 1.8.7 please see https://github.com/RobertDober/Forwarder.

## Abstract

Ruby's core Forwardable gets the job done(barely), but produces most unreadable code.

This is a nonintrusive (as is Forwardable) module that allows to delegate methods to instance variables,
objects returned by instance\_methods, other methods of the same receiver, the receiver itself, a chain of messages or
an arbitrary object. Paramters can be provided in the forwarding definition (parially or totally.

It also defines after and before filters.  and some more sophisticated use cases}

## License

This software is released under the very liberal MIT license as indicated in the attached file LICENSE.
If you do not have the LICENSE file delivered the terms of the license are referred to here:
http://www.opensource.org/licenses/mit-license.html

## Performance

Execution time is that of 85~95% of Forwardable by evalling strings whenever possible.


## Simple Delegation As In Forwardable

```ruby

forward <a_message>, to: <target>
forward <a_message>, to: <target>, as: <translation>
```

These two forms of the `forward` method, (and *only* these two forms) are directly implemented with
`def_delegator` method of `Forwardable`, as follows:

```ruby
def_delegator <target> <a_message>
def_delegator <translation> <a_message>
```

Furthermore the `forward_all` method is translated to the `def_delegators` method in the following form,
thusly

```ruby
forward_all msg1, msg2, msg3, ..., to: target
```
is implemented as 

```ruby
def_delegators target, msg1, msg2, msg3, ...
```

### Additional Features

* Parameters (partial or total application)
* Custom And Chained Targets
* AOP Filters
* Helpers


## Parameters


### Passing One Parameter

Assuming a class `ArrayWrapper` and that their instances wrap the array object via the instance variable
`@ary` the Smalltalk method `second` can be implemented as follows.

```ruby
require 'forwarder'
class ArrayWrapper
  extend Forwarder
  forward :second, to: :@ary, as: :[], with: 1
  ...
end
```

The `with` keyword paramter is thus used to provide the first slice of arguments that will be provided
to the forwarded invocation. This slice will be extended by the actual parameters of the invocation
of the proxy method (e.g. the instance method defined by the `forward` method itself).

### Passing More Parameters

If `with:` is passed an array, it is splatted into the invocation, thus allowing us to pass more than
one parameter. This becomes clearer with an example.

```ruby

   forward :add_whitespace_to_punctuation,
           to:   :name,
           as:   :gsub!,
           with: [ /[,.]\b/, '\& ' ]
```

### A Useful Shorthand

As I found myself using the following idioms all the time

```ruby

  forward :some_method, to: :@some_hash, as: :[], with: :some_method
  forward :other_method, to: :hash, as: :[], with: :other_key

```

I conceived the `to_hash` shortcut for these. Strictly spoken (and not striktly spoken
too) this is a gross generalisation of the usecase as if they target had to be a `Hash`
all the time. This is not the case of course, we are just forwarding a message with a
parameter...

Here is how the above idioms can be expressed by means of the `to_hash` target:

```ruby

   forward :some_method, to_hash: :@some_hash
   forward :other_method, to_hash: :hash, as: :other_key

```

Concerning jargon we are doing something a little bit confusing here. In all cases we have
an implicit translation (which is `:[]` of course). In the second case we have an explicit
translation (being `:other_key`) too. The explicit translation is transformed into the first,
and only argument, as we do not allow explicit arguments for `to_hash:` targets.

However you still can use the `forward_all` version and a `to_hash:` chain target, here is
an example:

```ruby

   class Params
     extend Forwarder
     forward_all :count, :limit, to_hash: [:@params, :mandatory]
     forward :pretend?, to_hash: [:@params, :optional], as: :dry_run
   end

```

AOP is not supported for `to_hash:` targets in this version, this might change in the future
as use cases are imaginable (e.g. an after filter for the `:pretend?` method, applying !! to
the result).

### Partial Application

This example gives us the oppurtunity to look at a use case for partial applications. Let us assume that
we do not always use whitespaces, than we can leave the second paramter to be provided by the invocation
of the defined forwarder proxy.

```ruby
   forward :add_something_to_punctuation,
           to:   :name,
           as:   :gsub!,
           with: /([,.])\b/
```

We can achieve the same as above with the following invocation

```ruby
   o = Name.new( "the,quick, fox." )
   o.add_something_to_punctuation( '\1 ' )
  # name: "the, quick, fox." )
```

but we can also add a hyphen after interpunctations with this invocation 

```ruby
   o = Name.new( "the,quick, fox." )
   o.add_something_to_punctuation( '\1- ' )
  # name: "the,- quick,- fox." )
```

But more importantely we can forward to the partial application, thus using the 
partial application as a mean of composition

```ruby
   forward :add_ws_to_punctuation,
           to_object: :self,
           as: :add_something_to_punctuation,
           with: '\1 '

   forward :add_hypen_to_punctuation,
           to_object: self,
           as: :add_something_to_punctuation,
           with_block: ->(*grps){ "#{grps.first}- " }
 
```

### Passing One Array

If a real array shall be passed in as one parameter it can be wrapped into an array of one element,
or the `with_ary:` keyword parameter can be used.

Example:

```ruby
  forward :append_suffix, to: :@ary, as: :concat, with: [%w{ my suffix }]
  forward :append_suffix, to: :@ary, as: :concat, with_ary: %w{ my suffix }
```

### Passing A Block

In case of the necessity to provide a block to the forwarded invocation, it can be specified as the
block parameter of the `forward` invocation itself.

The following example uses inject to compute a sum of elements

```ruby
  forward :sum, to: :elements, as: :inject do |s,e| s+e end
```

Please note however that common patterns like this one can benefit of the provided
helpers, in our case it is Integer.sum.

```ruby
require 'forwarder/helpers/integer/sum'
...
  forward :sum, to: :elements, as: :inject &Integer.sum
# or
  forward :sum, to: :elements, as: :inject, with_block: Integer.sum
...
```

Accounting for different tastes a block can be provided as a block parameter or 
as a `lambda` to the `with_block:` keyword parameter. The later is taking preference
over the former, which no defined usage of the block in this case (at least for
the time being).

### Selective Helpers

As we do not want to be intrusive the helpers
have to be requested explicitly.

This can be done in three levels of granularity:

* Per helper

`require 'forwarder/helpers/integer/sum'`

* All helpers

`require 'forwarder/helpers'`

* Per monkey patched class

`require 'forwarder/helpers/integer'`

## Custom And Chained Targets

So far the `to:` keyword was followed by a symbol or string denoting a _symbolic receiver_, that is
an instance_variable or method with the denoted name. Custom and Chain Targets are implementing a
different story.

### Chain Targets

Chain Targets are also expressed with the `to:` keyword parameter, but by passing an array of _symbolic receivers_.
This array will resolve to the final target by sending each message to the result of the preceding message. 
The following example should make this clearer:


```ruby
  forward :size, to: %w{@content children}
```

which could have been implemented by hand as follows:

```ruby
  def size
    @content.children.size
  end
```

### Custom Targets

Allow the user to define a target that cannot be expressed as a _symbolic receiver_.

Custom targets are expressed by the means of the `to_object:` keyword parameter.


I want to give two examples here, the first
using `self`, which evaluates to the module in which `forward` is invoked of course, and might
thus be used to forward to class instance methods, as in the following example:

```ruby
class Callback
  def self.instances; @__instances__ ||= [] end
    
  def self.register an_instance
    instances << an_instance
  end

  extend Forwarder
  forward :register, to_object: self

  def initialize
    register self
  end
end
```

But when looking closely one can see that the `self.register` method is just another delegation, thus the whole code
can be rewritten even more concesily as:

```ruby
class Callback
  class << self
    extend Forwarder
    forward :<<, to: :instances
  
    def instances; @__instances__ ||= [] end
  end

  extend Forwarder
  forward :register, to_object: self, as: :<<
end
```

The second example is a forward to the instance itself, for that purpose the symbol :self
can be used. The followin is, again, an implementation of Smalltalk's `second` method. But
here we are defining it on `Array` itself, not a wrapper.


```ruby
class Array
  extend Forwarder
  forward :second, to_object: :self, as: :[], with: 1
```

However the same could be accomplished by using the object/identity helper and the default
target implementation.

```ruby
require 'forwarder/helpers/object/identity'
class Array
  extend Forwarder
  forward :second, to: :identity, as: :[], with: 1
```

#### Custom Targets And Closures

Another application of custom targets would be to hide a enclosed object, but as in the first
example above, such an object cannot be defined on instance level, but only on class level.
Assuming that the class itself does not need access to the object enclosed by the closure, one
could easily implement an instance count for a class as follows:


```ruby

  container = []
  forward :register, to_object: container, as: :<<, with: :sentinel
  forward :instance_count, to_object: container, as: :size

```

## AOP Filters

Before and After filters are implemented in this version.

The respective `before:` and
`after:` keyword parameters expect lambdas as paramters, but by specifying the `:use_block`
value the block parameter of the `forward` method can be _abused_ for this purpose.

The following examples all operate on a class wrapping a hash instance via the `hash` attribute
reader. Our first goal is to implement a `max_value` method, that will return the maxium value
of all values for given keys.

### After Filter

The lambda provided by `after:` is applied to the return value of the forwarded invocation.
The following three examples all implement the `max_value` method correctly.


```ruby
  forward :max_value, to: :hash, as: :values_at, after: lambda{ |x| x.max }
  forward :max_value, to: :hash, as: :values_at, after: :use_block do | x | 
    x.max 
  end
  require 'forwarder/helpers/kernel/sendmsg'
  forward :max_value, to: :hash, as: :values_at, after: sendmsg( :max )
```

N.B. The `Kernel#sendmsg` method is my reply to the hated - by me that is at least - `Symbol#to_proc` kludge and its
limitations, I will talk about it more in the Helpers section.

### Before Filter.

Our next goal is to implement a method `value_of_max` that returns the value for the greatest of
all provided keys.

For this we will use a before filter, its lambda is applied to the arguments
of the implemented forwarder and the result will be passed in to the forwarded invocation. The pass in
will use a splash if appropriate.


```ruby
  forward :value_of_max, to: :hash, as: :[], before: lambda{ |*args| args.max }
  require 'forwarder/helpers/kernel/sendmsg'
  forward :value_of_max, to: :hash, as: :[], before: sendmsg( :max )
```

## Helpers

*N.B.* These are no longer part of Forwarder19, but have been moved into the gemdependency lab419_core.

Helpers define two type of methods. Firstly methods that return lambdas for frequently used
block patterns, e.g. `Integer.sum`. Secondly methods that are convenient to use inside `forward`
invocations, but not necessarily only there, e.g. `Kernel#sendmsg` or `Object#identity`.

### Functional Helpers

I see this second group, as small as it is, as an important enhancement for the functional
programming style. The possibilty to nullify a block that is necessarily used in a chain
of functional calls by passing in `{|x| x.identity}`, `sendmsg(:identity)` or even the 
hated `&:identity` is a recurring pattern. 

**Warning:** I will become evangelic now.

I do not like the `Symbol#to_proc` kludge, and that for two reasons. The first is pragamatic.
You cannot pass parameters, and that sucks. Why can I express `map(&:succ)` but not `map(&:+, 2)`.
Well the answer is clear, Ruby's syntax does not support it.

The second reason is on philosophical grounds. It feels wrong that Symbol shall be responsable
of transforming itself into a lambda.

Thus I created a helper in Kernel that takes the responsability, and doing so
with a clear name, expressing intent. This helper is `Kernel#sendmsg`.


```ruby
  map do |ele|
   ele.hello "World"
  end
```

is the same as


```ruby
  map( &sendmsg( :hello, "World") )
```

Furthermore it might be usuful to keep the returned `lambda` around, please compare

```ruby
  adder = sendmsg( :+ )
```
versus 

```ruby
  adder = :+.to_proc
```


Mapping with a `Symbol` might not only be conveniently expressed as sending a message to each
element, sometimes a different meaning might be appropriate as in the example below:


```ruby
  map do | ele |
    some_method ele
  end
```

A different helper can do this job without any ambiguity:


```ruby
  map( &applying( :some_method ) )
```

### Commonly Used Pattern Helpers

This group of helpers is just to avoid to rewrite lambdas you/one/whoever/I have written zillions of times. Here is a short list of examples
the API doc should give you enough information if you look for something specific.

#### Integer.sum

```ruby
  class Integer
    def self.sum
      ->(a, b){ a + b }
    end
  end
```

#### Integer#inc

```ruby
  class Integer
    alias_method :inc, :succ # should have used forward ;)
  end
```
