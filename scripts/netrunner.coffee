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
    robot.http("https://netrunnerdb.com/find/?q=#{query}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        image_path = $('.card-image img').first().attr('src')
        if image_path?
          title = $('h3.card-title a.card-title').first()
          robot.adapter.customMessage
            message: msg,
            attachments: [{
              title: title.text(),
              text: title.attr('href'),
              image_url: url.resolve('https://netrunnerdb.com', image_path)
            }]
        else
          card_names = $('a.card').map((i, el) -> $(el).text()).get()
          msg.send "#{card_names.length} found: " + card_names.join(', ')
