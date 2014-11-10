# Description
#   Display a Hearthstone card visual spoiler
#
# Dependencies:
#   "cheerio"
#   "url"
#
# Configuration:
#   None
#
# Commands:
#   hubot hearthstone <card> - Displays a image of the specified Hearthstone card
#
# Author:
#   woongy

cheerio = require('cheerio')
url = require('url')

module.exports = (robot) ->

  robot.respond /hearth(stone)? (.*)/, (msg) ->
    card = msg.match[2]
    robot.http("http://www.hearthhead.com/cards?filter=na=#{card}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        raw_script = $('#lv-hearthstonecards').next('script').html()
        card_id = raw_script.split('hearthstoneCards = [{"id":')[1].split(',')[0]
        robot.http("http://www.hearthhead.com/card=#{card_id}")
          .get() (err, res, body) ->
            $ = cheerio.load(body)
            raw_script = $('#main-contents .text h1').next('script').html()
            img_tag = raw_script.split('tooltip_premium_enus = \'')[1].split('<table>')[0]
            msg.send 'http:' + cheerio.load(img_tag)('img').attr('src')
