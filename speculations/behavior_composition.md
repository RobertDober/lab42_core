# lab42\_core

## Behavior

### All Behavior is Composable

The above methods all return instances of `Behavior` and `Behavior` has a much richer API than Ruby's core _callables_ like `Proc` or `Method` 

Example: Assemblage

```ruby :example
    double  = 2.fn.*
    inc2    = 2.fn.+
    dec     = Integer.fm.- 1

    expect(
      [1,2,3].map(&( inc2 | double | dec ))
      ).to eq([ 5, 7, 9 ])
```

Inspired by Elixir's `|>` we have `|` 

Example: We can of course mix all kind of Behavior

```ruby :example
    marker  = B(:<<, :mark)
    reverse = Array.fm.reverse
    doubler = [:a, :b].fn.* 2

    expect((doubler | marker | reverse).())
      .to eq([:mark, :b, :a, :b, :a])
```


