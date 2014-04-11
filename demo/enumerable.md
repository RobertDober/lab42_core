# Enumerable's High Order Methods


They are unified in the sense that all blocks can be replaced by `Behavior` where `Behavior` simply
stands for `Lambdas`, `Methods` or `Symbols`

Instead of
    (1..2).map(&:succ).assert == [2,3]

We can write

    require 'lab42/core/enumerable'
    (1..2).map(:succ).assert == [2,3]

But for more elaborate use cases we will rather
write things like:

    incrementer = ->(a){a+1}
    (1..2).map( incrementer ).assert == [2, 3]
    
All this seems, at first sight quite useless, but I found two reasons to do this, 
the first is to be able to free `Symbol` from the `to_proc` kludge, which is purely theoretical,
and the second, much more pratical, is to be able to combine behavior as necessary, and that
can be done with the `Behavior` class and its constructor `Kernel#Fn`

As such things like the following can be expressed in a truely functional
manner


    (1..2).map( Fn(:+, 2) + Fn(:*, 2) ).assert == [6, 8]

and even

    (1..2).map( Fn(:inc) * 2 + Fn(:*, 2 ) ).assert == [6, 8]

The real value of this might become clearer by looking at the Fn demo
