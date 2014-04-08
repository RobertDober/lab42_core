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
    


