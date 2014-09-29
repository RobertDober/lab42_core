# BRASS

[Website](http://rubyworks.github.com/brass) /
[Report Issue](http://github.com/rubyworks/brass/issues) /
[Development](http://github.com/rubyworks/brass)

[![Build Status](https://secure.travis-ci.org/rubyworks/brass.png)](http://travis-ci.org/rubyworks/brass)


# DESCRIPTION

BRASS is a standard assertions framework, framework's framework, or even
a framework's framework's framework, depending on where you're staking
out your assertions keister.

In other words, BRASS provides a standard rudimentary assertions framework
that all other assertion and test frameworks can use, or at least comply
with, and then everyone gets on swimingly.

Now, you may be thinking, "No thanks, I do it my way." But when you see
how stupid simple BRASS is, you'll realize that, "Yea, that actually 
make sense." And then maybe feel a bit stupid yourself for doing exactly
what this paragrah just said you would do. Yea, well, we've all been there.

But enough with the fluff.

BRASS defines two Kernel methods: `assert` and `refute`:

    assert(truthiness, *fail_arguments)
    refute(truthiness, *fail_arguments)

Where `truthiness` is any object evaluated for it's truth value (`false` and `nil`
are `false`, everything else is `true`), and `fail_arguments` are exactly the same
as those we would pass to the `fail` or `raise` methods.

The `assert` (and likewise `refute`) method does three things. First it tests the
`truthiness`, then it ticks up the appropriate counts in the global assertions
counter, and lastly, if truthiness came up short, it raises an error. This error
is either `RuntimeError` or the one specified by the `fail_arguments`.

The global assertions counter is `$ASSERTION_COUNTS`. It is simply a Hash formally
defined as:

    $ASSERTIONS_COUNTS = Hash.new{|h,k| h[k] = 0}

And though it is open to any key, the keys should be symbols. Three keys in 
particular and standard: `:pass`, `:fail` and `:total`. Whenever an assertion
passes, the `:pass` and `:total` counts are incremented, and whenever an assertion
fails the `:fail` and `:total` counts are incremented. You might wonder why
there is a total entry when the sum of the other two would do just as well. 
Well, other frameworks might want to add other counts, such as `:skip`. So
to ensure we still get the proper total despite this, we keep a separate tally.
Moving on....

Okay, last thing. When `assert` or `refute` raises an error, it marks the error
as an assertion via the `#set_assertion` method. This is a method extension
to the Exception class along with the `#assertion?` method which any
test framework can use to distinguish an assertion error from an ordinarily
error.

And that's all there is to it. If you *capice* then consider yourself top brass.

Love, Peace and Brass Knuckles


## COPYING

Copyright (c) 2010 Rubyworks. All rights reserved.

Distribute in accordance with the **BSD-2-Clause** license.

See COPYING.md file for details.
