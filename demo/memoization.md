
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

Are still *memoized* methods, as a convenience we can use `lazy_attr` if we want an even more static nature
of the method:

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

### The Non Standard Cases

#### Inheritance 


Works of course as expected

```ruby
    $classes = []
    class BClass
      memo :calculate do |op, lhs, rhs|
        $classes << BClass
        lhs.send op, rhs
      end
    end

    class DClass < BClass
      memo :calculate do |op, lhs, rhs|
        $classes << DClass
        super( op, lhs, rhs ).to_s
      end
    end
    b = BClass.new
    d = DClass.new
```

With this beautiful setup let us check some assumptions:

```ruby
    b.calculate( :+, 1, 41 ).assert == 42
    $classes.assert == [BClass]
    d.calculate( :+, 1, 41 ).assert == "42"
    $classes.assert == [BClass, DClass, BClass]
    d.calculate( :+, 1, 41 ).assert == "42"
    $classes.assert == [BClass, DClass, BClass]
```

If one is surprised about the last `B` in `$classes` she should so, but not because
of the memoization algorithm but because of the client's architecture. We are using
instances for methods not accessing any instance information. The next chapter will
demonstrate that memoization works on singletons too:

#### Module Singletons


```ruby
    $singletons = []
    module B extend self
      memo :calculate do |op, lhs, rhs|
        $singletons << B
        lhs.send op, rhs
      end
    end

    module D extend self
      extend B
      memo :calculate_s do |op, lhs, rhs|
        $singletons << D
        calculate( op, lhs, rhs ).to_s
      end
    end

    B.calculate( :+, 1, 41 ).assert == 42
    $singletons.assert == [B]
    D.calculate_s( :+, 1, 41 ).assert == "42"
    $singletons.assert == [B, D, B]
    D.calculate_s( :+, 1, 41 ).assert == "42"
    $singletons.assert == [B, D, B]
```

Still not the same receiver, what about service objects?

```ruby
    $services = [] 
    module Calc extend self
      memo :calculate do |op, lhs, rhs|
        $services << Calc
        lhs.send op, rhs
      end
    end
    module Stringer extend self
      memo :calculate do |op, lhs, rhs|
        $services << Stringer
        Calc.calculate( op, lhs, rhs ).to_s
      end
    end
    Calc.calculate( :+, 1, 41 ).assert == 42
    $services.assert == [Calc]
    Stringer.calculate( :+, 1, 41 ).assert == "42"
    $services.assert == [Calc, Stringer]
    Stringer.calculate( :+, 1, 41 ).assert == "42"
    $services.assert == [Calc, Stringer]
```

How meaningfull that the best architecture yields the best results.

#### Inclusion, Extension and Object Singletons

```ruby
    $count = 0
    module M
      memo :letters do | s |
        $count += 1
        s.gsub( /\W/, '' ).size
      end
    end
    class Alpha
      include M
    end
    a = Alpha.new
    a.letters("Hello World").assert == 10
    $count.assert == 1
    a.letters("Hello World").assert == 10
    $count.assert == 1
    a.letters("Hello World".reverse).assert == 10
    $count.assert == 2
```

What will happen if we redefine a memoized `letters` method, will there be a caching problem?

Let's demonstrate

```ruby
    class Alpha
      memo :letters do | s |
        $count += 10
        "whatever"
      end
    end
```

Obviously we do want the global variable `$count` be incremented by 10, once!

```ruby
    a.letters("Hello World").assert == "whatever"
    $count.assert == 12
    a.letters("Hello World").assert == "whatever"
    $count.assert == 12
```

Let us extend an objec with `M` now:

```ruby
    sing = Object.new
    sing.extend M
    
    sing.letters("Hello World").assert == 10
    $count.assert == 13
```

No side effects here, and memoization is in place, of course:

```ruby
    sing.letters("Hello World").assert == 10
    $count.assert == 13
```


### Unmemoization

We might need to recalculate memoized values, for that to work we can _temporarily_ invalidate the cache of
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
    
    Calculator.unmemoize_memo_calculate
    Calculator.calculate(:+, 1, 41).assert == 42
    Calculator.calculate(:+, 41, 1).assert == 42
    $count.assert == 4
    
```

However, if we invalidate the cache for a given parameter combination only, only
the invocation of the memoized method with exactly this parameter combination will
increment the count!

```ruby
    Calculator.unmemoize_memo_calculate :+, 41, 1
    Calculator.calculate(:+, 1, 41).assert == 42
    $count.assert == 4
    Calculator.calculate(:+, 41, 1).assert == 42
    $count.assert == 5
```

