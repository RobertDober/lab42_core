
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

### Lazy Attributes

```ruby
    
```
