# lab42\_core

## Dir

### Dir#files

```ruby
    demo   = File.join %w{demo fordir}
    prefix = File.join %w{.. ..}, demo # Get out of tmp/qed first!!!
    dir    = File.join prefix, %w{** *}


    dir_enum = Dir.files dir
    dir_enum.assert.kind_of? Enumerator
    dir_enum.to_a.sort.assert == %w{ 
      ../../demo/fordir/0
      ../../demo/fordir/subdir/1
    }.map{ |f|
      [f, File.expand_path(f.sub('../../demo', '..'), __FILE__ )]
    }
```

