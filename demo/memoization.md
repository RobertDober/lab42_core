
# lab42\_core


## Memoization and Lazy Attributes

### Memoization

#### Fibonacci

```ruby
      $count = 0
      memoize def fibo n
        $count += 1
        n < 2 ? n : fibo(n-1) + fibo(n-2)
      end

      fibo(7).assert == 13 
      $count.assert  == 8
```

#### A Shortcut for `memoize def`

```ruby
    $count = 0
    memo :double do | x |
      $count += 1
      2 * x
    end

    double(21).assert == 42
    double( 1).assert ==  2
    double(21).assert == 42
    $count.assert     ==  2

```


### Lazy Attributes

```ruby
    
      $count = 0
      class Lazy
        lazy_attr(  :a ){ $count += 1 }
        lazy_attr(  :b ){ a.tap{$count += 1}.succ }
      end
      lazy = Lazy.new
      
      # a is **alwyas** 1
      # b is **alwyas** 2

      lazy.b
      lazy.a.assert == 1
      lazy.b.assert == 2

      lazy.a; lazy.b
      lazy.a.assert == 1
      lazy.b.assert == 2
      $count.assert == 2

      $count = 100
      lazy.a.assert == 1
      lazy.b.assert == 2
```


### Unmemoization

We might need to recalculate memoized values, for that to work we can _temporaryly_ invalidate the cache of
the memoized method, we call this *Unmemoization*

Let us demonstrate with a first, simple example

```ruby
    $count = 0
    module Calculator extend self
      memo :calculate do |op, lhs, rhs|
        $count += 1
        lhs.send op, rhs
      end
    end
    
```

Now the count is of course incremented for each *different* calculation only.

```ruby

    Calculator.calculate(:+, 1, 41).assert == 42
    Calculator.calculate(:+, 41, 1).assert == 42
    $count.assert == 2
    Calculator.calculate(:+, 1, 41).assert == 42
    Calculator.calculate(:+, 41, 1).assert == 42
    $count.assert == 2

```

If we invalidate the cache of the whole method each parameter combination will
again increment the count.



```ruby
    
    Calculator.unmemoize_memo :calculate
    Calculator.calculate(:+, 1, 41).assert == 42
    Calculator.calculate(:+, 41, 1).assert == 42
    $count.assert == 4
    
```

However, if we invalidate the cache for a given parameter combination only, only
the invocation of the memoized method with exactly this parameter combination will
increment the count!

```ruby
    Calculator.unmemoize_memo :calculate, :+, 41, 1
    Calculator.calculate(:+, 1, 41).assert == 42
    $count.assert == 4
    Calculator.calculate(:+, 41, 1).assert == 42
    $count.assert == 5
```

