
# lab42\_core


## Array

### Context: flatten\_once

Example: Empty remains empty

```ruby :example
  expect( [].flatten_once ).to be_empty
    
```

Example: Flatter but not flattest

```ruby :example 
  expect( [[2, {a: 3}, [4]], {a: 5}].flatten_once )
    .to eq([2, {a: 3}, [4], {a: 5}])
    
  expect( [{a: 1}, [[{b: 2},[3]]]].flatten_once )
    .to eq([{a: 1}, [{b: 2}, [3]]])
```
