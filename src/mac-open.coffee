###
node-mac-open
https://github.com/weareinteractive/node-mac-open

Copyright (c) 2013 We Are Interactive
Licensed under the MIT license.
###

"use strict"

path = require("path")
exec = require("child_process").exec

###
Opens files from a shell.
By default, opens each file using the default application for that file.
If the file is in the form of a URL, the file will be opened as a URL.

@param {string} filenames The files to open.
@param {object} [options] Options to open the file
@param {function(error)} [callback] Called with null on success, or an error object that contains a property 'code' with the exit code of the process.
@return {ChildProcess} The child process object.
###
module.exports = (filenames, options={}, callback=null) ->
  return false unless filenames?

  cmd = ["open"]
  test = false

  if options.test? and options.test is true
    delete options.test
    test = true

  for key, value of options
    do (key, value) ->
      if value is true
        cmd.push "-#{key}"
      else if typeof value is "string"
        value = "\"#{value}\""
        cmd.push "-#{key} #{value}"

  cmd.push escape(filenames)
  if test then cmd.join(' ') else exec cmd.join(' '), callback

###
@param {string} value Value to escape
@return {string}
###
escape = (value) ->
  '"' + value.replace(/(["\s'$`\\])/g,'\\$1') + '"'
