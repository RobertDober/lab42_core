# lab42\_core

## Functors

### Functional Composition

and to go beyond

```ruby
    name_size = M[:name] + M.size
    select_name_size = M.map( &name_size )
  
    select_name_size.( dramatis_personae ).assert == [4, 6, 1]
```

#### Pipelines

Pipelines are nice semantic sugar for much more readable functional composition

```ruby
    P( dramatis_personae, select_name, F.size ).assert == [4, 6, 1]
```

If `#|` is not defined on your initial value this syntax can be used too:


```ruby
    (dramatis_personae | select_name | F.size ).().assert == [4, 6, 1]
```

You might want to know, why the additional `.()` at the end of the pipeline?

Well pipes are lazy, meaning that the **huge** array above will be iterated over only once.

With a block like `Proc<from composed fns>`

IOW `Functor#|` just returns a new `Functor` therefore the following is maybe the most 
_logical_ code.

```ruby
    ( select_name | F.size | F.*(2) ).( dramatis_personae ).assert == [8, 12, 2] 
```


#### Killer Feature: Iterables

We love to write code like this, because it accords to our (well mine, at least) way of thinking:

```ruby
    db = { 'person' => { name: 'Riker', grade: 'Cmd' } }
    some_data = [] # Huge in reality
    []
      .select(&:odd?)
      .map{ |idx| db["person"].find( idx ) }
      .select{ |p| p.age > 42 }
      .map{ |p| p.values_at( :first_name, :last_name ).join( ' ' ) }
```

This is highly ineffeciant unless we use a truely [lazy collection](https://github.com/RobertDober/lab42_streams) 

Functional Composition cannot achieve the same level of efficency, but almost

```ruby
    ( M.select(&F.odd?) | M.map(&(F.[](db, 'person'))) | M.find(F.>(10)) ).( [] ) 
```

This is because it is too early to achieve composition, by using [Streams](https://github.com/RobertDober/lab42_streams) we
can combine all code blocks when we eventually realize a value and not before.


### Etc.

