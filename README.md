


# lab42\_core


[![Build Status](https://travis-ci.org/RobertDober/lab42_core.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_core)
[![Code Climate](https://codeclimate.com/github/RobertDober/lab42_core/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_core)
[![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_core/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_core)


Simple Ruby Core Module Extensions (for more see lab42\_more)

## Array

Can be used after `require 'lab42/core'` or `require 'lab42/core/array'`  

### flatten\_once

```ruby
    [].flatten_once.assert.empty?

    [[2, {a: 3}, [4]], {a: 5}].flatten_once.assert ==
      [2, {a: 3}, [4], {a: 5}]
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/array.md).

## Dir

Can be used after `require 'lab42/core'` or `require 'lab42/core/dir'`  

```ruby
  Dir.files "**/*" do | partial_path, full_path |
  end
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/dir.md).

## Enumerable

### grep2

```ruby
  enum.grep2 expr # ===>
  enum.partition{ |ele| expr === ele }
```

### to\_proc

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

## File

`expand_local_path` to get rid of the `__FILE__` inside `expand_path`.

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/file.md).

## Hash

```ruby
  {a: 42, b: 43}.only :a, :c # ===> {a: 42}
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_core/blob/master/demo/hash.md).

## Fn

Has been moved into gem [lab42\_more](https://github.com/RobertDober/lab42_more)

## OpenObject

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
