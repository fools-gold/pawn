# Description
#   Display a Hearthstone card visual spoiler
#
# Dependencies:
#   "cheerio"
#
# Configuration:
#   None
#
# Commands:
#   hubot hearth(stone) <card> - Displays a image of the specified Hearthstone card
#   hubot hearth(stone) golden <card> - Displays a gif of the golden version of the specified Hearthstone card
#
# Author:
#   woongy

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /hearth(stone)? (golden(?= ))?(.*)/, (msg) ->
    golden = msg.match[2]
    card = msg.match[3]
    robot.http("http://www.hearthhead.com/cards?filter=na=#{card}")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        raw_script = $('#lv-hearthstonecards').next('script').html()
        card_id = raw_script.split('hearthstoneCards = [{"id":')[1].split(',')[0]
        robot.http("http://www.hearthhead.com/card=#{card_id}")
          .get() (err, res, body) ->
            $ = cheerio.load(body)
            raw_script = $('#main-contents .text script').first().html()
            if golden?
              img_tag = raw_script.split('tooltip_premium_enus = \'')[1].split('<table>')[0]
              msg.send 'http:' + cheerio.load(img_tag)('img').attr('src')
            else
              img_tag = raw_script.split('tooltip_enus = \'')[1].split('<table>')[0]
              msg.send 'http:' + cheerio.load(img_tag)('img').attr('src')

