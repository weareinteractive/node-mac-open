"use strict"

chai = require('chai')
open = require('../../')

assert = chai.assert
chai.Assertion.includeStack = true

# See http://visionmedia.github.io/mocha/ for Mocha tests.
# See http://chaijs.com/api/assert/ for Chai assertion types.

###
NOTE: this is not really an automated test suite.
It does not check that the applications are actually opened. This needs
to be verified manually. It *does* ensure that the opener command is called right.
###
module.exports =
  "Test open":
    "with no options": (done) ->
      assert.isFalse open()
      done()
    "url with default Browser": (done) ->
      options =
        test: true
      assert.equal open("http://www.weareinteractive.com", options), "open \"http://www.weareinteractive.com\""
      done()
    "current directory with Finder": (done) ->
      options =
        g: true
        a: "Finder"
        test: true
      assert.equal open(__dirname, options), "open -g -a \"Finder\" \"#{__dirname}\""
      done()
