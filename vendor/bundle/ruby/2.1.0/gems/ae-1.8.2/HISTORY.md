# RELEASE HISTORY

## 1.8.2 / 2013-02-18

This release primarily fixes one bug --the assertions count
global variable wasn't all caps, which prevented assertions
from being counted correctly.

Changes:

* Fix $ASSERTION_COUNTS letter case.


## 1.8.1 / 2011-12-04

Fixed missing ae/ansi.rb file from distribution.

Changes:

* Update manifest, missing ae/ansi.rb


## 1.8.0 / 2011-12-03 / Checkered Flag

This new release improves support for Proc-based assertions and
RSpec-style matchers. In addition, this release sees the optional
Check Ok/No library in a usable state. And, lastly, note the license
has been changed to BSD-2-Clause.

Changes:

* Finalize the Check mixin API.
* Improve Proc and RSpec-style matchers.
* Modernize the build configuration.
* Change licenses to BSD-2-Clause.


## 1.7.4 / 2011-06-08

Quick release fixes an issue due to Ruby 1.9+'s constant look-up
system. Yes, BasicObject has no clue. This is fixed using the
`const_missing` hook.

Changes:

* Add const_missing hook to Assertor class to redirect to 
  toplevel methods.

## 1.7.3 / 2011-06-06 / D-Day

This release simply adds a new optional help library, `ok.rb`.
The API is still in it's infancy, so it probably will change
but this early release can help refine it's development.

Changes:

* Add option `ok` helper library.


## 1.7.2 / 2011-06-02

Minor release adds color diffs for failed equality comparisons to
the error message, and it fixes an issue in which class references
needed the toplevel prefix (`::`) to ensure they can be found in 
all cases. Note that ANSI color diffs can be deactivated via
AE.ansi = false or using the master switch an upcoming release
of the ANSI gem.

Changes:

* Add toplevel prefix (`::`) to class references in assertor.rb.
* Provide ANSI colored diffs for failed equality comparisons.


## 1.7.1 / 2011-05-06

This release adds a specialized message for certain comparison
operators to allow them have a more forensic output. This is done
via ANSI::Diff library. This release also deprecates the optional
dot.rb and detest.rb emulation scripts.

Changes:

* Add special message for comparison assertions.
* Remove optional dot.rb and detest.rb emulation scripts.


## 1.7.0 / 2011-04-28

AE now uses proper namespace for all classes. In particular, the `Assertor`
class has become `AE::Assertor`. Only the `Assertion` class remains outside
the `AE` namespace, as it is now used to map to the current exception class
for raising assertions as defined by current test framework. In addition,
AE's Kernel extensions, which are used to adapt AE for use with any given
test framework have been moved to the AE and AE::Assertor classes as
class methods along with AE's assertion count methods.

Changes:

* All AE classes use proper namespace.
* Framework methods moved to AE::Assertor class.
* Assertion count tracking methods moved to AE::Assertor class.
* AE::Assertion class simplified to a simple subclass of Exception.


## 1.6.1 / 2010-11-05

This release has test passing for Ruby 1.9.2. Ruby 1.9.2 doesn't appear
to like &block and block_given? to be used in same method scope. It
may be a Ruby bug, nonetheless AE has been adjusted to circumvent the
problem.

Changes:

* Use `&block` and not `block_given?`.


## 1.6.0 / 2010-11-04

Support libraries defining toplevel methods, such as `legacy.rb`, now place
their methods in AE::World module instead of Object. AE::World needs to
to be included in the context desired for the testing framework used. This
is important to prevent pollution of the Object namespace.

Changes:

* Toplevel extras are defined in AE::World instead of Object.
* In dot.rb #true/#false methods renamed to `#true!`/`#false!`.
* In dot.rb `#true!`/`#false!` methods can take an error or error message.


## 1.5.0 / 2010-09-06

This release adds adapters for TestUnit, MiniTest and RSpec. AE worked with
them previously but AE assertions were seen as errors rather than nice
assertions. Likewise assertion counts were off in the final tally. These
adapters insert AE's counts so the tally are correct.

In addition to this the Assertion class itself now acts as the final end
point for all assertions, which makes for a very clean interface.

Changes:

* Add adapters for TestUnit, MiniTest and RSpec.
* Move final assertion call to Assertion#test.


## 1.4.0 / 2010-09-02

Version 1.4 brings Ruby 1.9 compatibility. The Assertor class is now a
subclass of BasicObject. This fixes an issues Assertor would had
applying to methods defined both in a class and Kernel.

Changes:

* Assertor is a subclass of BasicObject.
* Use custom BasicObject when using Ruby 1.8.
* Add #assert= which works like `assert ==`.
* Add #refute= which works like `refute ==`.


## 1.3.0 / 2010-06-17

New release of AE adds support for RSpec-style matchers. This means
it should be usable with Shoulda 3.0 and any other matchers library.
This release also cleans up the underlying code, which is now
extremely clean. Lastly a small API change allows #assert to compare
it's argument to the return of it's block using #==, just as #expect
does using #===.

Changes:

* Add RSpec-style matchers support.
* Move #expect code to Assertor.
* #assert method can do equality comparison.


## 1.2.3 / 2010-06-07

This release is a quick fix, which adds a missing `require 'yaml'`.

Changes:

* Add missing require 'yaml'.


## 1.2.2 / 2010-06-06

Version 1.2.2 simply add one new feature --the ability to
use 'object.assert = other' instead of 'object.assert == other'.
This was added simply because I found I often made the mistake
of a missing '=', and since #assert= has no definition, there
was no reason not to have behave accordingly.

Also note that I switched the license from LGPL to MIT.
With regards to reusable libraries and I moving all my
work, such that I am able, to MIT to maximize free usage.

Changes:

* Add `#assert=` method as a shortcut for `#assert ==`.
* Now distributed under MIT license.


## 1.2.0 / 2010-01-27

This release fixes '=~' assertions and now requires the
ae/expect library by default.

Changes:

* Expect method is now loaded by default when requiring 'ae'.
* Fixed bug where #=~ did not work correctly against Assertor.


## 1.1.0 / 2009-09-06

This release provided two major improvements. The first is
the #expect method which is similar to #assert, but uses 
case equality (#===) for comparison. And second, an optional
library `ae/legacy.rb`, is has been added that provides
backward compatibility with Test::Unit assertions, should it
be needed.

Changes:

* New #expect method.
* Proved legacy assertion in optional ae/legacy.rb library.
* Added backtrace parameter to flunk calls.


## 1.0.0 / 2009-09-03

This is the initial release of AE.

Changes:

* Happy Birthday!

