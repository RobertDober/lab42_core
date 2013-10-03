# lab42\_core

Ruby Core Module Extensions (in the spirit of lab419/core)

## Dir

```ruby
  Dir.files "**/*" do | partial_path, full_path |
  end
```

## Enumerable

```ruby
  enum.grep2 expr # ===>
  enum.partition{ |ele| expr === ele }
```

## Hash

```ruby
  {a: 42, b: 43}.only :a, :c # ===> {a: 42}
```

## Fn

Must be required specifically!

```ruby
  require 'lab42/core/fn'

  # Get method of an object
  printer = Kernel.fn.puts
  printer.( 42 )   
  2.times(&printer)

  # It also extends some enumerable methods for easier execution
  %w{hello world}.each printer
```
