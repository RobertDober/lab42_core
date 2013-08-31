# lab42\_core

Ruby Core Module Extensions (in the spirit of lab419/core)

## Dir

```ruby
  Dir.walk "**/*" do | partial_path, full_path |
  end
```

## Enumerable

```ruby
  enum.grep2 expr # ===>
  enum.partition{ |ele| expr === ele }
```
