// Generated by CoffeeScript 1.10.0
exports.challenge = function() {
  var number;
  number = Math.floor(Math.random() * 10);
  return {
    question: {
      start: number
    },
    answer: {
      end: number
    }
  };
};