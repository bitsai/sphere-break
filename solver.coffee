@solve = (entryCoins, borderCoins) ->
  for coreNum in [2..9]
    coreNum + ': ' + bestSequence entryCoins, borderCoins, coreNum

bestSequence = (entryCoins, borderCoins, coreNum) ->
  seqs = validSequences entryCoins, borderCoins, coreNum
  seqs.sort ([_, a2, a3], [_, b2, b3]) -> a2 * a3 - b2 * b3
  seqs.pop()

validSequences = (entryCoins, borderCoins, coreNum) ->
  seqs = []
  for e in entryCoins
    for [b1, b2] in allPairs borderCoins
      seq = [e, b1, b2]
      seqs.push seq if isValidSequence seq, coreNum
  seqs

allPairs = (items) ->
  pairs = []
  for pair in kCombinations 2, items
    pairs.push pair
    pairs.push (pair.slice 0).reverse()
  pairs

isValidSequence = ([coin1, coin2, coin3], coreNum) ->
  (!isMultiple coin1, coreNum) and
  (!isMultiple coin1 * coin2, coreNum) and
  (isMultiple coin1 * coin2 * coin3, coreNum)

isMultiple = (x, y) ->
  x % y == 0

# Use the Banker's Sequence algorithm to generate k-combinations
# http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.18.6972

kCombinations = (k, items) ->
  idxs = (0 for x in [0...items.length])
  for indexCombination in indexCombinations idxs, 0, k
    (items[i] for i in indexCombination)

indexCombinations = (idxs, pos, maxPos) ->
  if pos < maxPos
    start = if pos == 0 then 0 else idxs[pos - 1] + 1
    combs = []
    for i in [start...idxs.length]
      idxs[pos] = i
      combs = combs.concat indexCombinations idxs, pos + 1, maxPos
    combs
  else
    [idxs.slice 0, maxPos]

# console.log @solve [1,2,3,7], [1,6,5,9,3,8,6,3,4,4,9,7]
