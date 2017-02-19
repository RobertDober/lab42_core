# lab42\_core

## Behavior

### All Behavior is Composable

The above methods all return instances of `Behavior` and `Behavor` has a much richer API than Ruby's core _callables_ like `Proc` or `Method` 

Example:

```ruby
    double  = 2.fn.*
    inc2    = 2.fn.+
    dec     = Integer.fm.- 1

    [1,2,3].map(&( inc2 | double | dec )).assert == [ 5, 7, 9 ]
```

We can of course mix all kind of Behavior

```ruby
    marker  = B(:<<, :mark)
    reverse = Array.fm.reverse
    doubler = [:a, :b].fn.* 2

    (doubler | marker | reverse).().assert == [:mark, :b, :a, :b, :a]
```


