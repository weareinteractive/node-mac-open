###
mac-open
https://github.com/weareinteractive/node-mac-open

Copyright (c) 2013 We Are Interactive
Licensed under the MIT license.
###

"use strict"

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    coffeelint:
      files: ["Gruntfile.coffee", "src/**/*.coffee", "test/**/*.coffee"]
      options:
        max_line_length:
          value: 200
          level: "error"

    coffee:
      lib:
        files:
          "lib/<%= pkg.name %>.js": "src/<%= pkg.name %>.coffee"

    # Unit tests.
    mochacov:
      options:
        bail: true
        ui: 'exports'
        require: 'coffee-script'
        compilers: ['coffee:coffee-script/register']
        files: 'test/specs/**/*.coffee'
      test:
        options:
          reporter: 'spec'
      coverage:
        options:
          coveralls: true

    # Deployment
    bumper:
      options:
        push: false
        createTag: false
        tasks: ["default"]
        files: ["package.json"]
        updateConfigs: ["pkg"]

  # Load npm tasks.
  grunt.loadNpmTasks "grunt-mocha-cov"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-bumper"

  # Default task.
  grunt.registerTask "default", ["coffeelint", "coffee"]
  grunt.registerTask "test", ["default", "mochacov:test"]
  grunt.registerTask "travis", ["test", "mochacov:coverage"]
