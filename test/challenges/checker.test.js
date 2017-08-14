// Generated by CoffeeScript 1.10.0
var chai, expect, subject;

chai = require("chai");

subject = require("../../challenges/checker");

expect = chai.expect;

describe('check', function() {
  it('notes that objects are the same', function() {
    return expect(subject.check({
      a: 1,
      b: "hello"
    }, {
      b: "hello",
      a: 1
    })).to.be["true"];
  });
  it('notes that objects are different', function() {
    return expect(subject.check({
      a: 1,
      b: "hello"
    }, {
      b: "bye",
      a: 2
    })).to.be["false"];
  });
  it('is happy if the second argument contains extras', function() {
    return expect(subject.check({
      a: 1,
      b: "hello"
    }, {
      c: "huh?!?",
      b: "hello",
      a: 1
    })).to.be["true"];
  });
  return it('is unhappy if the second argument is missing stuff', function() {
    return expect(subject.check({
      a: 1,
      b: "hello"
    }, {
      b: "bye"
    })).to.be["false"];
  });
});