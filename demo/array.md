
# lab42\_core


## Array

### flatten\_once

```ruby

    [].flatten_once.assert.empty?

    [[2, {a: 3}, [4]], {a: 5}].flatten_once.assert ==
      [2, {a: 3}, [4], {a: 5}]

    [{a: 1}, [[{b: 2},[3]]]]
      .flatten_once
      .assert == [{a: 1}, [{b: 2}, [3]]]
```

### merge

Without a block it is _roughly_ the same as `zip.flatten_once.compact` 

```ruby
    [1,2,3].merge( [:a,:b], ['hello'] ).assert == [1, :a, "hello", 2, :b, 3] 
```

A block will determine from which of all the arrays the next value will be
taken. Simply by returning its index in the argument list, where 0 indicates
the receiver, 1 the first argument and so on.

In this example we want to merge values together that have the same modulus.
Note that not all values are necessarily merged.


```ruby
    [1, 3, 2, 4].merge( [103, 102, 101] ){ |a,b| a == (b%100) ? 1 : 0 }.assert == [1, 103, 3, 102, 2, 4]
    # the following lines show the values for a and b at each iteration            ^    ^  ^    ^  ^  ^
    #                                                                              |    |  |    |  |  |
    #                 a: 1, b: 103 ------------------------------------------------+    |  |    |  |  |
    #                 a: 3, b: 103 -----------------------------------------------------+  |    |  |  |
    #                 a: 3, b: 102 --------------------------------------------------------+    |  |  |
    #                 a: 2, b: 102 -------------------------------------------------------------+  |  |
    #                 a: 2, b: 101 ----------------------------------------------------------------+  |
    #                 a: 4, b: 101 -------------------------------------------------------------------°
    #   Exhaustion of receiver terminates iteration
```

The following showes that exhaustion of an argument also terminates iteration in case of the block
version

```ruby
    [1, 3, 2, 4].merge( [103, 102] ){ |a,b| a == (b%100) ? 1 : 0 }.assert == [1, 103, 3, 102]
    # Exhaustion of first argument terminates iteration -- thus nil % 100 does not raise an error    
```

We can however decide to ignore errors in the block and take the next available argument

```ruby
    [1, 3].merge!( [ 101, nil, 103 ] ){ |a,b| a == (b%100) ? 1 : 0 }.assert == [101, 1, 3, nil, 103]
```



### Demonstrating the README

```ruby
     [0,5,10].merge( [2, 4, 5], [3,9] ){ |a,b,c| a == [a,b,c].min ?  0 : ( b < c ? 1 : 2 ) }.assert == [0,2,3,4,5,5,9,10]  
```
