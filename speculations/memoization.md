
# lab42\_core


## Memoization and Lazy Attributes

### Memoization

#### Fibonacci


```ruby :example memoize 
      $count = 0
      class X
        memoize def fibo n
          $count += 1
          n < 2 ? n : fibo(n-1) + fibo(n-2)
        end
      end

      expect(X.new.fibo(7)).to eq(13)
      expect($count).to eq(8)
```

#### A Shortcut for `memoize def`

```ruby :example Memo Shortcut
    $count = 0
    class Y
      memo :double do | x |
        $count += 1
        2 * x
      end
    end

    y = Y.new
    expect(y.double(21)).to eq(42)
    expect(y.double(1)).to eq(2)
    expect(y.double(21)).to eq(42)
    expect($count).to eq(2)
```


### Lazy Attributes

Are still *memoized* methods, as a convenience we can use `lazy_attr` if we want an even more static nature
of the method:

```ruby :example Lazy Attributes
    
      $count = 0
      class Lazy
        lazy_attr( :a ){ $count += 1 }
        lazy_attr( :b ){ a.tap{$count += 1}.succ }
      end
      lazy = Lazy.new
      
      # a is **alwyas** 1
      # b is **alwyas** 2

      lazy.b
      expect(lazy.a).to eq(1)
      expect(lazy.b).to eq(2)

      lazy.a; lazy.b
      expect(lazy.a).to eq(1)
      expect(lazy.b).to eq(2)
      expect($count).to eq(2)

      $count = 100
      expect(lazy.a).to eq(1)
      expect(lazy.b).to eq(2)
```

### The Non Standard Cases

#### Inheritance ...


... does, of courese, work as expected

```ruby :include
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

```ruby :example Inheritance
    expect(b.calculate( :+, 1, 41 )).to eq(42)
    expect($classes).to eq([BClass])
    expect(d.calculate( :+, 1, 41 )).to eq("42")
    expect($classes).to eq([BClass, DClass, BClass])
    expect(d.calculate( :+, 1, 41 )).to eq("42")
    expect($classes).to eq([BClass, DClass, BClass])
```

If one is surprised about the last `B` in `$classes` she should so, but not because
of the memoization algorithm but because of the client's architecture. We are using
instances for methods not accessing any instance information. The next chapter will
demonstrate that memoization works on singletons too:

#### Module Singletons


```ruby :example Singletons
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

    expect(B.calculate( :+, 1, 41 )).to eq(42)
    expect($singletons).to eq([B])
    expect(D.calculate_s( :+, 1, 41 )).to eq("42")
    expect($singletons).to eq([B, D, B])
    expect(D.calculate_s( :+, 1, 41 )).to eq("42")
    expect($singletons).to eq([B, D, B])
```

Still not the same receiver, what about service objects?

```ruby :example Service Objects (what a hype word!!!)
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
    expect(Calc.calculate( :+, 1, 41 )).to eq(42)
    expect($services).to eq([Calc])
    expect(Stringer.calculate( :+, 1, 41 )).to eq("42")
    expect($services).to eq([Calc, Stringer])
    expect(Stringer.calculate( :+, 1, 41 )).to eq("42")
    expect($services).to eq([Calc, Stringer])
```

How meaningful that the best(*) architecture yields the best results.

#### Inclusion, Extension and Object Singletons

```ruby :example Bestness (for some)
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
    expect(a.letters("Hello World")).to eq(10)
    expect($count).to eq(1)
    expect(a.letters("Hello World")).to eq(10)
    expect($count).to eq(1)
    expect(a.letters("Hello World".reverse)).to eq(10)
    expect($count).to eq(2)
```

(*) Bestness lies in the eyes of the beholder


What will happen if we redefine a memoized `letters` method, will there be a caching problem?

Let's speculate

```ruby :example
    class Alpha
      memo :letters do | s |
        $count += 10
        "whatever"
      end
    end
```

Obviously we do want the global variable `$count` be incremented by 10, once!

```ruby :example Redefinitions
    a = Alpha.new
    expect(a.letters("Hello World")).to eq("whatever")
    expect($count).to eq(12)
    expect(a.letters("Hello World")).to eq("whatever")
    expect($count).to eq(12)
```

Let us extend an objec with `M` now:
No side effects here, and memoization is in place, of course:

```ruby :example Extensions
    sing = Object.new.extend M
    expect(sing.letters("Hello World")).to eq(10)
    expect($count).to eq(13)
    expect(sing.letters("Hello World")).to eq(10)
    expect($count).to eq(13)
```


### Unmemoization

We might need to recalculate memoized values, for that to work we can _temporarily_ invalidate the cache of
the memoized method, we call this *Unmemoization*

Let us speculate with a first, simple example

```ruby :include
    $count = 0
    module Calculator extend self
      memo :calculate do |op, lhs, rhs|
        $count += 1
        lhs.send op, rhs
      end
    end
    
```

Now the count is of course incremented for each *different* calculation only.

```ruby :example Before Unmemoization

    $count = 0
    expect(Calculator.calculate(:+, 1, 41)).to eq(42)
    expect(Calculator.calculate(:+, 41, 1)).to eq(42)
    expect($count).to eq(2)
    expect(Calculator.calculate(:+, 1, 41)).to eq(42)
    expect(Calculator.calculate(:+, 41, 1)).to eq(42)
    expect($count).to eq(2)

```

If we invalidate the cache of the whole method each parameter combination will
again increment the count.



```ruby :example After Unmemoization
    
    Calculator.unmemoize_memo_calculate
    expect(Calculator.calculate(:+, 1, 41)).to eq(42)
    expect(Calculator.calculate(:+, 41, 1)).to eq(42)
    expect($count).to eq(4)
    
```

However, if we invalidate the cache for a given parameter combination only, only
the invocation of the memoized method with exactly this parameter combination will
increment the count!

```ruby :example Partial Unmemoization
    Calculator.unmemoize_memo_calculate :+, 41, 1
    expect(Calculator.calculate(:+, 1, 41)).to eq(42)
    expect($count).to eq(4)
    expect(Calculator.calculate(:+, 41, 1)).to eq(42)
    expect($count).to eq(5)
```

