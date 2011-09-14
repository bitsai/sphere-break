# Use the Banker's Sequence algorithm to generate k-combinations
# http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.18.6972

exports.kCombinations = (k, items) ->
  array = (0 for x in [0...items.length])
  for indexCombination in indexCombinations array, 0, k
    (items[i] for i in indexCombination)

indexCombinations = (array, pos, maxPos) ->
  if pos < maxPos
    start = if pos == 0 then 0 else array[pos - 1] + 1
    combs = []
    for i in [start...array.length]
      array[pos] = i
      combs = combs.concat indexCombinations array, pos + 1, maxPos
    combs
  else
    [array.slice 0, maxPos]
