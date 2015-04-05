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

#### If No Block Given We Do Something Sensitive (TM)

```ruby
    fn_sizes = Dir.files %w{.. .. demo fordir ** * }, :size
    fn_sizes.assert == [2, 2] # Each yielded param is an ary with rel and abs path
```

### Relative and Absolute Path Variations

#### Relative Path

```ruby
    rel_dirs = Dir.rel_files dir, :itself
    rel_dirs.assert == dir_enum.map(&:first)
```

#### Absolute Path

```ruby
    abs_dirs = Dir.abs_files dir, :itself
    abs_dirs.assert == dir_enum.map(&:last)
```
