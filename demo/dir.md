# lab42\_core

## Dir

### Dir#files

```ruby
    dir = File.join %w{demo fordir ** *}
    Dir.files dir do | partial_path, full_path |
      partial_path.assert == File.join( dir, "0" )
      full_path.assert == File.join( PROJECT_DIR, partial_path )
      break
    end

    dir_enum = Dir.files dir
    dir_enum.assert.kind_of? Enumerator
    dir_enum.to_a.assert == [ File.join( dir, "0" ), File.join( dir, "subdir", "1" ) ]
      .map{ |partial_path| [ partial_path, File.join( PROJECT_DIR, partial_path ) ] }
```

