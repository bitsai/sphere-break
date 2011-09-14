@solve = (entryCoins, borderCoins) ->
  for coreNum in [2...10]
    coreNum + ': ' + bestCombination entryCoins, borderCoins, coreNum

bestCombination = (entryCoins, borderCoins, coreNum) ->
  validCombs = validCombinations entryCoins, borderCoins, coreNum
  validCombs.sort ([_, a2, a3], [_, b2, b3]) -> a2 * a3 - b2 * b3
  validCombs.pop()

validCombinations = (entryCoins, borderCoins, coreNum) ->
  combs = []
  for a in entryCoins
    for [b, c] in kCombinations 2, borderCoins
      comb = [a, b, c]
      combs.push comb if isValidCombination comb, coreNum
  combs

isValidCombination = ([coin1, coin2, coin3], coreNum) ->
  (!isMultiple coin1, coreNum) and
  (!isMultiple coin1 * coin2, coreNum) and
  (isMultiple coin1 * coin2 * coin3, coreNum)

isMultiple = (x, y) ->
  x % y == 0

# Use the Banker's Sequence algorithm to generate k-combinations
# http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.18.6972

kCombinations = (k, items) ->
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

# console.log solve [1,2,3,7], [1,6,5,9,3,8,6,3,4,4,9,7]
