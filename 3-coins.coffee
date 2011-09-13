comb = require './combinations.coffee'

isMultiple = (x, y) ->
  x % y == 0

isValidSequence = (coins, coreNum) ->
  (!isMultiple coins[0], coreNum) and
  (!isMultiple coins[0] * coins[1], coreNum) and
  (isMultiple coins[0] * coins[1] * coins[2], coreNum)

validSequences = (entryCoins, borderCoins, coreNum) ->
  seqs = []
  for entryCoin in entryCoins
    for borderCoinPair in comb.combinations borderCoins, 2
      seq = [entryCoin].concat borderCoinPair
      seqs.push seq if isValidSequence seq, coreNum
  seqs

bestSequence = (entryCoins, borderCoins, coreNum) ->
  validSeqs = validSequences entryCoins, borderCoins, coreNum
  validSeqs.sort (a, b) -> a[1] * a[2] - b[1] * b[2]
  validSeqs.pop()

solve = (entryCoins, borderCoins) ->
  (x + ': ' + bestSequence entryCoins, borderCoins, x for x in [2...10])

console.log solve [1,2,3,7], [1,6,5,9,3,8,6,3,4,4,9,7]
