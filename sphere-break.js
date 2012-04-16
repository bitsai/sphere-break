var SPHERE_BREAK = (function () {
    'use strict';

    var pub = {};

    function isFactor(x, y) {
        return y % x === 0;
    }

    function isValidCombo(coreNum, combo) {
        return !isFactor(coreNum, combo[0])
            && !isFactor(coreNum, combo[0] + combo[1])
            &&  isFactor(coreNum, combo[0] + combo[1] + combo[2]);
    }

    function getPairs(coins) {
        var pairs = [];
        var i, j;
        for (i = 0; i < coins.length - 1; i++) {
            for (j = i + 1; j < coins.length; j++) {
                pairs.push([coins[i], coins[j]]);
                pairs.push([coins[j], coins[i]]);
            }
        }
        return pairs;
    }

    function getCombos(entryCoins, borderCoins) {
        var combos = [];
        _.each(entryCoins, function (c) {
            _.each(getPairs(borderCoins), function (pair) {
                combos.push([c, pair[0], pair[1]]);
            });
        });
        return combos;
    }

    function getBestCombo(coreNum, entryCoins, borderCoins) {
        return _.chain(getCombos(entryCoins, borderCoins))
            .filter(function (c) { return isValidCombo(coreNum, c); })
            .max(function (c) { return c[1] * c[2]; })
            .value();
    }

    function getInputs(grid, type) {
        return _.filter(grid.elements, function (e) {
            return e.className === type && e.value !== '';
        });
    }

    pub.solveGrid = function (grid) {
        var entryCoins = _.map(getInputs(grid, 'entry'), function (e) {
            return parseInt(e.value, 10);
        });
        var borderCoins = _.map(getInputs(grid, 'border'), function (e) {
            return parseInt(e.value, 10);
        });
        var solutions = _.map(_.range(2, 10), function (coreNum) {
            return coreNum + ': ' + getBestCombo(coreNum, entryCoins, borderCoins);
        });
        pub.setOutput(solutions.join('<br>'));
    };

    pub.incBorderCoins = function (grid) {
        _.each(getInputs(grid, 'border'), function (e) {
            var x = parseInt(e.value, 10);
            e.value = (x < 9) ? x + 1 : '';
        });
    };

    pub.setOutput = function (text) {
        document.getElementById('output').innerHTML = text;
    };

    return pub;
}());
