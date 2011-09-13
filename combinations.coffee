# Use the Banker's Sequence algorithm to generate k-combinations
# http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.18.6972

indexCombinations = (arr, pos, maxPos) ->
  if pos >= maxPos
    [arr.slice 0, maxPos]
  else
    start = if pos == 0 then 0 else arr[pos - 1] + 1
    combs = []
    for i in [start...arr.length]
      arr[pos] = i
      combs = combs.concat indexCombinations arr, pos + 1, maxPos
    combs

exports.combinations = (coll, k) ->
  arr = (0 for x in [0...coll.length])
  combs = []
  for indexCombination in indexCombinations arr, 0, k
    combs.push (coll[i] for i in indexCombination)
  combs
