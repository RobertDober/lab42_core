# lab42\_core

## File

### expand\_local\_path


Instead of writing e.g. `File.expand_path File.join('..', 'a', 'b'), __FILE__ )` 
you can write `File.expand_local_path{ %w{a b} }`. 

Of course if you want to count on the omnipresence of `/` as a file separator , as so many seem to do
nowadays you can write code like `File.expand_local_path{'a/b'}` 

```ruby
    File.expand_local_path{ %w{a b} }.assert ==
      File.expand_path( File.join( %w{.. a b} ), __FILE__ )
```

