# Description
#   Display a Dominion card visual spoiler
#
# Dependencies:
#   "cheerio"
#   "url"
#
# Configuration:
#   None
#
# Commands:
#   hubot dominion <card> - Displays a image of the specified Dominion card
#
# Author:
#   woongy

cheerio = require('cheerio')
url = require('url')

module.exports = (robot) ->

  robot.respond /dominion (.*)/, (msg) ->
    card = msg.match[1]
    robot.http("http://dominion.diehrstraits.com/?card=#{card}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        msg.send url.resolve('http://dominion.diehrstraits.com', $('img.card_img').first().attr('src'))
