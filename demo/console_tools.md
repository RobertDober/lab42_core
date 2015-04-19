# lab42\_core

## Console Tools

```ruby
    require 'lab42/core/console_tools'
```

### Why?

We are in the console, having some fun? Maybe. Debugging a dev problem? Probably. Tracking Donw a Critical Production Bug? Possibly!

We want tools which allow us to go fast, focus on the problem, exploy possibilities, with a minimum of typing and a maximum of abstraction.

If you agree with the above assesments, just load your console with `lab42/core/console_tools` and then do things like the following:

```ruby
    values = [ {id: 1, name: 'git'}, {id: 2, name: 'ruby'}, {id: 3, name: 'vim'} ]
    
    # method map
    values.mm(:[], :name).assert == %w{ git ruby vim }
```



