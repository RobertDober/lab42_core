
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

