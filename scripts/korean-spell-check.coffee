# Description
#   Display a summary of a board game from BoardGameGeek
#
# Dependencies:
#   "cheerio"
#
# Configuration:
#   None
#
# Commands:
#   hubot 맞춤법 <sentence> - 네이버 맞춤법 검사기로 문장 교정
#
# Author:
#   woongy

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /맞춤법 (.*)/, (msg) ->
    sentence = msg.match[1]
    robot.http("http://csearch.naver.com/dcontent/spellchecker.nhn?_callback=&q=#{sentence}")
      .get() (err, res, body) ->
        data = JSON.parse /^\((.*)\);$/.exec(body)[1]
        msg.send cheerio.load(data.message.result.html).root().text()
