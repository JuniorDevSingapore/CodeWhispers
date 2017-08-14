// Generated by CoffeeScript 1.10.0
var branch, connection, round;

connection = require('./connection');

branch = require('./branch');

round = require('./round');

exports.nextRound = function(req, res) {
  return branch.performSwap(function(branchMapping) {
    return round.increment().then(function(number) {
      return res.status(200).json({
        round: number,
        mapping: branchMapping
      });
    })["catch"](function(error) {
      return res.status(500).send(error);
    });
  });
};