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

colors = {
  "Anarch": "#ff4500",
  "Criminal": "#4169e1",
  "Shaper": "#32cd32",
  "Haas-Bioroid": "#8a2be2",
  "Jinteki": "#ed143d",
  "NBN": "ff8c00",
  "Weyland Consortium": "#006400",
  "Neutral": "#808080",
  "Adam": "#808080",
  "Apex": "#808080",
  "Sunny Lebeau": "#808080",
}

module.exports = (robot) ->

  robot.respond /netrunner (.*)/, (msg) ->
    query = msg.match[1]
    robot.http("https://netrunnerdb.com/find/?q=#{query}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        image_path = $('.card-image img').first().attr('src')
        if image_path?
          title = $('h3.card-title a.card-title').first()
          set = $('ul.pager li:nth-child(2) a').first()
          prop = $('span.card-prop').first()
          influence = Array(parseInt(prop.text().match(/Influence: (\d)/)[1]) + 1).join('•');
          faction = $('.card-illustrator small').first().text().match(/^\s+\b(.+) •/)[1];

          robot.emit 'slack.attachment',
            message: msg,
            attachments: [{
              color: colors[faction],
              title: "#{title.text()} #{influence} (#{set.text()})".replace(/\s+/g, ' '),
              text: title.attr('href'),
              image_url: url.resolve('https://netrunnerdb.com', image_path)
            }]
        else
          card_names = $('a.card').map((i, el) -> $(el).text()).get()
          msg.send "#{card_names.length} found: " + card_names.join(', ')
