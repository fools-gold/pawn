# Description
#   Display a Netrunner card visual spoiler
#
# Dependencies:
#   "cheerio"
#   "url"
#
# Configuration:
#   None
#
# Commands:
#   hubot netrunner <card> - Displays a image of the specified Netrunner card
#
# Author:
#   woongy

cheerio = require('cheerio')
url = require('url')

module.exports = (robot) ->

  robot.respond /netrunner (.*)/, (msg) ->
    query = msg.match[1]
    robot.http("http://netrunnerdb.com/find/?q=#{query}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        image_path = $('.card-image img').first().attr('src')
        if image_path?
          msg.send url.resolve('http://netrunnerdb.com', image_path)
        else
          card_names = $('a.card').map((i, el) -> $(el).text()).get()
          msg.send "#{card_names.length} found: " + card_names.join(', ')
