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
    query = msg.match[1]
    robot.http("http://dominion.diehrstraits.com/?card=#{query}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        card_name = $('img.card_img').first().attr('alt')
        image_url = url.resolve('http://dominion.diehrstraits.com', $('img.card_img').first().attr('src'))
        msg.send image_url
        msg.send image_url if card_name is 'Rats'
