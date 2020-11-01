# lab42\_core

## File

### expand\_local\_path


Instead of writing e.g. `File.expand_path File.join('..', 'a', 'b'), __FILE__ )` 
you can write `File.expand_local_path{ %w{a b} }`. 

Of course if you want to count on the omnipresence of `/` as a file separator, as so many seem to do
nowadays you can write code like `File.expand_local_path{'a/b'}` 

```ruby :example
    expect(File.expand_local_path{ %w{a b} })
      .to eq(File.expand_path( File.join( %w{.. a b} ), __FILE__ ))
```

### if\_readable

Instead of writing an `if` we can pass a block to the `File.if_readable` method.
This allows also for functional composition which is not possible with `if` 

```ruby :include
    let(:forfile) { File.join %w{speculations forfile } }
    let(:readable_file) { File.join forfile, "readable"}
    let(:writable_file) { File.join forfile, "writable"}
    let(:unaccessable_file) { File.join forfile, "unaccessable"}
```


```ruby :example readable

    action = nil
    File.if_readable readable_file do | file |
      expect( file ).to be_instance_of(File)
      expect(file.path).to eq(readable_file)
      action = :readable_file
    end
    expect( action ).to eq(:readable_file)
```

However nothing will happen with an unaccessable file

```ruby :example
    action = :readable_file
    File.if_readable unaccessable_file do
      action = unexpected!
    end
    expect(action).to eq(:readable_file)
```


### if\_writable

```ruby :example

    action = nil
    File.if_writable writable_file do
      action = :writable_file
    end
    expect(action).to eq(:writable_file)
    
```

However nothing will happen with an unaccessable or solely readable file

```ruby :example not writable
    action = :writable_file
    File.if_writable unaccessable_file do
      action = unexpected!
    end
    expect(action).to eq(:writable_file)
```

```ruby :example 
    action = :writable_file
    File.if_writable readable_file do
      action = unexpected!
    end
    expect(action).to eq(:writable_file)
```

### as Enumerator

If no block is provided both methods `if_readable` and `if_writeable` are transformed into an Enumerator.

```ruby :example
    never = File.if_writable readable_file
    once  = File.if_writable writable_file

    expect(never).to be_kind_of(Enumerator)
    expect(once).to be_kind_of(Enumerator)

    expect{ never.next }.to raise_error(StopIteration)

    expect(once.next).to eq(writable_file)
    expect{ once.next }.to raise_error(StopIteration)

```
