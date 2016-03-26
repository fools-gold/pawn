# Description
#   Capture today's weather forecast from m.weather.naver.com
#
# Dependencies:
#   "phantomjs-prebuilt"
#   "imgur"
#
# Configuration:
#   None
#
# Commands:
#   hubot (weather|forecast) - Displays a captured image of today's weather forecast
#   hubot weekly (weather|forecast) - Displays a captured image of next 10 day's weather forecast
#
# Author:
#   woongy

path = require('path')
childProcess = require('child_process')
phantomjs = require('phantomjs-prebuilt')
binPath = phantomjs.path
imgur = require('imgur')

module.exports = (robot) ->

  robot.respond /(weekly )?(weather|forecast)/, (msg) ->
    childArgs = [path.join(__dirname, "../lib/capture-weather.js"), msg.match[1]?.trim()]

    childProcess.execFile binPath, childArgs, (err, stdout, stderr) ->
      if err?
        msg.send "something went wrong :("
      else
        imgur.uploadFile("weather.png").then (json) ->
          msg.send json.data.link
