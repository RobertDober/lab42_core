
# lab42\_core


## Array

### flatten\_once

```ruby

    [].flatten_once.assert.empty?

    [[2, {a: 3}, [4]], {a: 5}].flatten_once.assert ==
      [2, {a: 3}, [4], {a: 5}]

    [{a: 1}, [[{b: 2},[3]]]]
      .flatten_once
      .assert == [{a: 1}, [{b: 2}, [3]]]
```
