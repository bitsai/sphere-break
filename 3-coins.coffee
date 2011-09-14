comb = require './combinations.coffee'

solve = (entryCoins, borderCoins) ->
  for x in [2...10]
    x + ': ' + bestSequence entryCoins, borderCoins, x

bestSequence = (entryCoins, borderCoins, coreNum) ->
  validSeqs = validSequences entryCoins, borderCoins, coreNum
  validSeqs.sort ([_, a2, a3], [_, b2, b3]) -> a2 * a3 - b2 * b3
  validSeqs.pop()

validSequences = (entryCoins, borderCoins, coreNum) ->
  seqs = []
  for a in entryCoins
    for [b, c] in comb.kCombinations 2, borderCoins
      seq = [a, b, c]
      seqs.push seq if isValidSequence seq, coreNum
  seqs

isValidSequence = ([coin1, coin2, coin3], coreNum) ->
  (!isMultiple coin1, coreNum) and
  (!isMultiple coin1 * coin2, coreNum) and
  (isMultiple coin1 * coin2 * coin3, coreNum)

isMultiple = (x, y) ->
  x % y == 0

console.log solve [1,2,3,7], [1,6,5,9,3,8,6,3,4,4,9,7]
