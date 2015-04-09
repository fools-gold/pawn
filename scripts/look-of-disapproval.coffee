# Description
#   Give a look of disapproval
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lod @<name> - Give a look of disapproval to the named person
#
# Author:
#   woongy

module.exports = (robot) ->

  robot.respond /lod @(\w+)/i, (msg) ->
    name = msg.match[1]
    msg.send "ಠ_ಠ @#{name}"
