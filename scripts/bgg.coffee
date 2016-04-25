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
        title = $('#results_objectname1 > a').text()
        year = $('#results_objectname1 > span').text()
        rating = $('#CEcell_objectname1 ~ .collection_bggrating').eq(1).text().trim()
        stars = Array(Math.round(parseFloat(rating)) + 1).join(':star:')
        msg.send "#{title} #{year} #{stars} #{rating}"
        msg.send title_url
