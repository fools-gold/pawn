# Description
#   Display a summary of a movie title from IMDb
#
# Dependencies:
#   "cheerio"
#   "url"
#
# Configuration:
#   None
#
# Commands:
#   hubot (movie|imdb) <title> - Displays a summary of the specified movie from IMDb
#
# Author:
#   woongy

cheerio = require('cheerio')
url = require('url')

module.exports = (robot) ->

  robot.respond /(movie|imdb) (.*)/, (msg) ->
    query = msg.match[2]
    robot.http("http://www.imdb.com/find?s=tt&ttype=ft&q=#{query}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        title_url = url.resolve('http://www.imdb.com', $('.result_text > a').attr('href'))
        robot.http(title_url)
          .get() (err, res, body) ->
            $ = cheerio.load(body)
            title = $('h1.header > span[itemprop="name"]').text()
            year = $('h1.header > span.nobr').text()
            rating = $('span[itemprop="ratingValue"]').text()
            stars = Array(Math.round(parseFloat(rating)) + 1).join(':star:')
            canonical_url = $('link[rel="canonical"]').attr('href')
            msg.send "#{title} #{year} #{stars} #{rating}"
            msg.send canonical_url
