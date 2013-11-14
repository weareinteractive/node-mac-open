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

    mochaTest:
      test:
        options:
          bail: true
          ui: 'exports'
          require: 'test/coverage'
        src: ['test/**/*.coffee']
      'html-cov':
        options:
          quiet: true
          reporter: 'html-cov'
          captureFile: 'test/coverage.html'
        src: ['test/specs/**/*.test.coffee']
      'coveralls-cov':
        options:
          quiet: true
          reporter: 'mocha-lcov-reporter'
        src: ['test/specs/**/*.test.coffee']

    bump:
      options:
        pushTo: 'origin'
        commitFiles: ['-a']
        updateConfigs: ['pkg']
        files: ['package.json']

  # Load npm tasks.
  grunt.loadNpmTasks "grunt-mocha-test"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-bump"

  # Default task.
  grunt.registerTask "default", ["coffeelint", "coffee"]
  grunt.registerTask "test", ["default", "mochaTest"]