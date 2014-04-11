# Behavior and its Factory Method Fn

Behavior is an abstraction over lambdas, and its factory method Fn can be used
to give _lambda_ behavior to symbols (instead of the horrible to_proc kludge) and
thus unify the arguments to HO functions/methods.

But the main purpose of Behavior is to make _lambdas_ composable.

The classical application of function composer is f * g meaning f applied to the
application of g.

    ( Fn( :+, 1 ) * Fn( :*, 2 ) ).(20).assert == 41

This is not always intutive and many prefer the pipeline notation to express the 
same semantics

    ( Fn( :+, 1 ) | Fn( :*, 2 ) ).(20).assert == 42

Furthermore we can apply the whole pipeline naturally to a non Behavior value

    result = Fn(:+, 1) | Fn( :*, 2) | Fn(:-, 2) | 21
    result.assert == 42

As we cannot override the | method on Object we need a helper method if we want to pipe
a value into a pipeline

    result = 21.into Fn(:+, 1) | Fn( :*, 2) | Fn(:-, 2)
    result.assert == 42

All this is straightforward for single values, but what about multiple values. A priori
we cannot distinguish if an array represents a single value, as in the following use case

    result = (1..2).into Fn(:map, Fn(:succ)) | Fn(:filter, Fn(:odd?))
    result.assert == [ 3 ]

We need a helper that will splash to get this right:

    result = args(1,2).into Fn( ->(a,b){ [b, a] } ) | Fn(:-)
    result.assert == 1

This means unfortunately that we cannot just create a procedure to be called
but have either to stock the pipelined Behaviors and call them on realization
or compose lambdas that have to check if they have been called with one arg or 
with an args result.


From Multiplication follows Potentation

    result = 1.into Fn( :succ ) ** 3
    result.assert == 4

In order to execute a side effect function n times we cannot pass it into n.times unless
it takes a param, this can easily be avoided by

    side_effect = Fn( ->{ puts "hello" } )
    args().into side_effect ** n

