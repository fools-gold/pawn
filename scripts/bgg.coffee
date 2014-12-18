# Description
#   Display a summary of a board game from BoardGameGeek
#
# Dependencies:
#   "cheerio"
#   "url"
#
# Configuration:
#   None
#
# Commands:
#   hubot bgg <title> - Displays a summary of the specified board game from BGG
#
# Author:
#   woongy

cheerio = require('cheerio')
url = require('url')

module.exports = (robot) ->

  robot.respond /bgg (.*)/, (msg) ->
    query = msg.match[1]
    robot.http("https://boardgamegeek.com/geeksearch.php?action=search&objecttype=boardgame&q=#{query}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        title_url = url.resolve('https://boardgamegeek.com', $('#results_objectname1 > a').attr('href'))
        robot.http(title_url)
          .get() (err, res, body) ->
            $ = cheerio.load(body)
            title = $('span[property~="v:itemreviewed"]').text()
            year = $('h1.geekitem_title > span.mf').text()
            rating = $('span[property~="v:average"]').text()
            stars = Array(Math.round(parseFloat(rating)) + 1).join(':star:')
            msg.send "#{title} #{year} #{stars} #{rating}"
            msg.send title_url
