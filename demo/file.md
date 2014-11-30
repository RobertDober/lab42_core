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

### if\_readable

Instead of writing an `if` we can pass a block to the `File.if_readable` method.
This allows also for functional composition which is not possible with `if` 


```ruby
    forfile           = File.join %w{.. .. demo forfile } # Get out of tmp/qed first!!!

    readable_file     = File.join forfile, "readable"
    writable_file     = File.join forfile, "writable"
    unaccessable_file = File.join forfile, "unaccessable"

    action = nil
    File.if_readable readable_file do | file |
      file.assert.instance_of? File
      file.path.assert == readable_file
      action = :readable_file
    end
    action.assert == :readable_file
```

However nothing will happen with the unaccessable file

```ruby
    File.if_readable unaccessable_file do
      action = unexpected!
    end
    action.assert == :readable_file
```


### if\_writable

```ruby

    action = nil
    File.if_writable writable_file do
      action = :writable_file
    end
    action.assert == :writable_file
    
```


