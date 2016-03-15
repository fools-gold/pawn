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
        image = $('img.card-img').first()
        card_name = image.attr('alt')
        image_url = url.resolve('http://dominion.diehrstraits.com', image.attr('src'))
        msg.send image_url
        msg.send image_url if card_name is 'Rats'
