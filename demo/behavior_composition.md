# lab42\_core

## Behavior

### All Behavior is Composable

The above methods all return instances of `Behavior` and `Behavor` has a much richer API than Ruby's core _callables_ like `Proc` or `Method` 

Example:

```ruby
    double  = 2.fn.*
    inc2    = 2.fn.+
    dec     = Fixnum.fm.- 1

    [1,2,3].map(&( inc2 | double | dec )).assert == [ 5, 7, 9 ]
```

