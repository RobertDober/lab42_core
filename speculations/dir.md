# lab42\_core

## Dir

### Dir#files

```ruby :include
  let(:speculations) {File.join %w{speculations fordir}}
  let(:dir) { File.join speculations, %w{** *} }
  let(:dir_enum) {Dir.files dir}
```

```ruby :example

    expect( dir_enum ).to be_kind_of(Enumerator)
    expect(dir_enum.to_a.sort).to eq(%w{ 
      speculations/fordir/0
      speculations/fordir/subdir/1
    }
      .map{ |f|
        [f, File.join(Dir.pwd, f)]
      }
    )
```

#### If No Block Given We Do Something Sensitive (TM)

```ruby :example
    fn_sizes = Dir.files %w{ speculations fordir ** * }, :size
    expect(fn_sizes).to eq([2, 2]) # Each yielded param is an ary with rel and abs path
```

### Relative and Absolute Path Variations

Example: Relative Path

```ruby :example
    rel_dirs = Dir.rel_files dir, :itself
    expect(rel_dirs).to eq(dir_enum.map(&:first))
```

Example: Absolute Path

```ruby :example
    abs_dirs = Dir.abs_files dir, :itself
    expect(abs_dirs).to eq(dir_enum.map(&:last))
```

Example: It is particulary useful for mass requires

```ruby :example
   require 'lab42/core/fn'
   Dir.abs_files %w{speculations forrequire *.rb}, Kernel.fn.require
   expect(Alpha).to be_kind_of(Module)
   expect(Beta).to be_kind_of(Module)
```

