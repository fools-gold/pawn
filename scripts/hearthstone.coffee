# Description
#   Display a Hearthstone card visual spoiler
#
# Dependencies:
#   "cheerio"
#
# Configuration:
#   None
#
# Commands:
#   hubot hearth(stone) <card> - Displays a image of the specified Hearthstone card
#   hubot hearth(stone) golden <card> - Displays a gif of the golden version of the specified Hearthstone card
#
# Author:
#   woongy

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /hearth(stone)? (golden )?(.*)/, (msg) ->
    golden = msg.match[2]
    card = msg.match[3]
    robot.http("http://hearthstone.services.zam.com/v1/card?search=#{card}")
      .get() (err, res, body) ->
        media = JSON.parse(body)[0].media
        if golden?
          url = media.find((obj) -> obj.type == 'GOLDEN_CARD_IMAGE').url
          msg.send "http://media.services.zam.com/v1/media/byName#{url}"
        else
          url = media.find((obj) -> obj.type == 'CARD_IMAGE').url
          msg.send "http://media.services.zam.com/v1/media/byName#{url}"
