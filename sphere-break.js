var solveGrid = function(grid) {
    var entryCoins = _.map(getInputs(grid, "entry"), function(e) {
	return parseInt(e.value);
    });
    var borderCoins = _.map(getInputs(grid, "border"), function(e) {
	return parseInt(e.value);
    });
    var solutions = _.map(_.range(2, 10), function(coreNum) {
	return coreNum + ": " + getBestCombo(coreNum, entryCoins, borderCoins);
    });
    setOutput(solutions.join("<br>"));
}

var incBorderCoins = function(grid) {
    _.each(getInputs(grid, "border"), function(e) {
	var x = parseInt(e.value);
	if (x < 9) e.value = x + 1;
	else e.value = "";
    });
}

var setOutput = function(text) {
    document.getElementById("output").innerHTML = text;
}

var getInputs = function(grid, type) {
    return _.filter(grid.elements, function(e) {
	return e.className === type && e.value != "";
    });
}

var getBestCombo = function(coreNum, entryCoins, borderCoins) {
    return _.chain(getCombos(entryCoins, borderCoins))
	.filter(function(c) { return isValidCombo(coreNum, c); })
	.max(function(c) { return c[1] * c[2]; })
	.value();
}

var getCombos = function(entryCoins, borderCoins) {
    var combos = [];
    _.each(entryCoins, function(c) {
	_.each(getPairs(borderCoins), function(pair) {
	    combos.push([c, pair[0], pair[1]]);
	});
    });
    return combos;
}

var getPairs = function(coins) {
    var pairs = [];
    for (var i = 0; i < coins.length - 1; i++) {
	for (var j = i + 1; j < coins.length; j++) {
	    pairs.push([coins[i], coins[j]]);
	    pairs.push([coins[j], coins[i]]);
	}
    }
    return pairs;
}

var isValidCombo = function(coreNum, combo) {
    return combo
	&& !isFactor(coreNum, combo[0])
	&& !isFactor(coreNum, combo[0] + combo[1])
	&&  isFactor(coreNum, combo[0] + combo[1] + combo[2]);
}

var isFactor = function(x, y) {
    return y % x === 0;
}
