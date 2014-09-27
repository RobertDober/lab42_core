# lab42\_core

## Dir

### Dir#files

```ruby
    demo   = File.join %w{demo fordir}
    prefix = File.join %w{.. ..}, demo # Get out of tmp/qed first!!!
    dir    = File.join prefix, %w{** *}

    Dir.files dir do | partial_path, full_path |
      partial_path.assert == File.join( prefix, "0" )
      full_path.assert == File.join( PROJECT_DIR, demo, "0" )
      break
    end

    dir_enum = Dir.files dir
    dir_enum.assert.kind_of? Enumerator
    dir_enum.to_a.assert ==  [
      ["../../demo/fordir/0", "/home/robert/git/lab42/core/demo/fordir/0"],
      ["../../demo/fordir/subdir/1", "/home/robert/git/lab42/core/demo/fordir/subdir/1"]
    ]
```

