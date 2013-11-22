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
        compilers: ['coffee:coffee-script']
        files: 'test/specs/**/*.coffee'
      all:
        options:
          reporter: 'spec'
      coverage:
        options:
          coveralls:
            serviceName: 'travis-ci'
      htmlcoverage:
        options:
          reporter: 'html-cov'
          output: 'test/coverage.html'

    # Deployment
    bump:
      options:
        pushTo: 'origin'
        commitFiles: ['-a']
        updateConfigs: ['pkg']
        files: ['package.json']

  # Load npm tasks.
  grunt.loadNpmTasks "grunt-mocha-cov"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-bumper"

  # Default task.
  grunt.registerTask "default", ["coffeelint", "coffee"]
  grunt.registerTask "test", ["default", "mochacov:all", "mochacov:htmlcoverage"]
  grunt.registerTask "test:travis", ["default", "mochacov:all", "mochacov:coverage"]
