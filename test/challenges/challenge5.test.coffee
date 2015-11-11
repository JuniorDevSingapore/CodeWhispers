chai = require "chai"
subject = require "../../challenges/challenge5"
challengeUtils = require "../../challenges/challengeUtils"
_ = require "underscore"

expect = chai.expect

describe 'challenge4', ->
  it 'returns a string of FBLR for instructions', ->
    challenge = subject.challenge()
    expect(challenge.question.instructions.length).to.be.above(0)
    _.each challenge.question.instructions, (char) ->
      expect(['F', 'B', 'L', 'R']).to.include(char)

  it 'provides startX and startY as numbers', ->
    challenge = subject.challenge()
    expect(challenge.question.startX).to.be.a('number')
    expect(challenge.question.startY).to.be.a('number')

  it 'provides treasureX and treasureY as numbers', ->
    challenge = subject.challenge()
    expect(challenge.question.treasureX).to.be.a('number')
    expect(challenge.question.treasureY).to.be.a('number')

  it 'provides correct endX and endY', ->
    challenge = subject.challenge()
    q = challenge.question
    a = challenge.answer
    instructions = q.instructions.split('')
    [expectedEndX, expectedEndY] = challengeUtils.calculateEndPosition(instructions, [q.startX, q.startY])
    expect(a.endX).to.equal(expectedEndX)
    expect(a.endY).to.equal(expectedEndY)

  it 'marks the treasure as found when it should', ->
    challenge = subject.getChallenge(true)
    a = challenge.answer
    expect(a.treasureFound).to.be.true

  it 'marks the treasure as not found when it should', ->
    challenge = subject.getChallenge(false)
    a = challenge.answer
    expect(a.treasureFound).to.be.false

  it 'places the treasure on the route when found', ->
    challenge = subject.getChallenge(true)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    expect(route).to.contain.something.that.deep.equals([q.treasureX, q.treasureY])

  it 'places the treasure off the route when not found', ->
    challenge = subject.getChallenge(false)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    expect(route).not.to.contain.something.that.deep.equals([q.treasureX, q.treasureY])

  it 'places the treasure on the route dependent on random selection', ->
    challenge = subject.challenge()
    q = challenge.question
    a = challenge.answer
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    if a.treasureFound
      expect(route).to.contain.something.that.deep.equals([q.treasureX, q.treasureY])
    else
      expect(route).not.to.contain.something.that.deep.equals([q.treasureX, q.treasureY])

  it 'places the pirate on the route when met', ->
    challenge = subject.getChallenge(false, true)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    expect(route).to.contain.something.that.deep.equals([q.pirateX, q.pirateY])

  it 'places the pirate off the route when not met', ->
    challenge = subject.getChallenge(false, false)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    expect(route).not.to.contain.something.that.deep.equals([q.pirateX, q.pirateY])

  it 'places the spy on the route when met', ->
    challenge = subject.getChallenge(false, false, true)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    expect(route).to.contain.something.that.deep.equals([q.spyX, q.spyY])

  it 'places the spy off the route when not met', ->
    challenge = subject.getChallenge(false, false, false)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    expect(route).not.to.contain.something.that.deep.equals([q.spyX, q.spyY])

  it 'places the pirate on after after treasure when both found', ->
    challenge = subject.getChallenge(true, true)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    treasureIndex = route.reduce (itemAt, pos, index) ->
      if !itemAt && pos[0] == q.treasureX && pos[1] == q.treasureY
        itemAt = index
      itemAt
    , undefined

    pirateIndex = route.reduce (itemAt, pos, index) ->
      if pos[0] == q.pirateX && pos[1] == q.pirateY
        itemAt = index
      itemAt
    , undefined

    expect(pirateIndex).to.be.least(treasureIndex)

  it 'places the spy on or before treasure when both found', ->
    challenge = subject.getChallenge(true, false, true)
    q = challenge.question
    instructions = q.instructions.split('')
    route = challengeUtils.calculatePath(instructions, [q.startX, q.startY])

    treasureIndex = route.reduce (itemAt, pos, index) ->
      if !itemAt && pos[0] == q.treasureX && pos[1] == q.treasureY
        itemAt = index
      itemAt
    , undefined

    spyIndex = route.reduce (itemAt, pos, index) ->
      if !itemAt && pos[0] == q.spyX && pos[1] == q.spyY
        itemAt = index
      itemAt
    , undefined

    expect(spyIndex).to.be.most(treasureIndex)

  it 'marks the treasure as stolen when both treasure and pirate found', ->
    challenge = subject.getChallenge(true, true)
    a = challenge.answer
    expect(a.treasureStolen).to.be.true

  it 'marks the treasure as not stolen if either treasure or pirate not found', ->
    challenge = subject.getChallenge(false, true)
    a = challenge.answer
    expect(a.treasureStolen).to.be.false

    challenge = subject.getChallenge(true, false)
    a = challenge.answer
    expect(a.treasureStolen).to.be.false

    challenge = subject.getChallenge(false, false)
    a = challenge.answer
    expect(a.treasureStolen).to.be.false