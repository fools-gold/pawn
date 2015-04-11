# Description
#   Notify cool boardgame selling articles at divedice
#
# Dependencies:
#   "cheerio"
#   "iconv"
#
# Configuration:
#   None
#
# Commands:
#   hubot cool start - Start cool stuff notification
#   hubot cool interval <mins> - Change the interval of cool stuff notification
#   hubot cool stop - Stop cool stuff notification
#
# Author:
#   hwidong

cheerio = require('cheerio')
Iconv = require('iconv').Iconv
iconv = new Iconv('EUC-KR', 'UTF-8//TRANSLIT//IGNORE');
DIVEDICE_SELLING_LIST_URL = "http://www.divedice.com/shop/gboard/bbs/board.php?bo_table=mkt"

module.exports = (robot) ->
  init = false
  timer = 0
  interval = 5
  last_article_checked = 0

  robot.respond /cool start/i, (msg) ->
    if not init
      init = true
      setTimer interval, msg
      msg.send "쿨매 알림 시작! 5분에 한 번씩 작동합니다."
    else
      msg.send "쿨매 알림이 이미 작동중입니다."

  robot.respond /cool stop/i, (msg) ->
    if init
      init = false
      clearTimeout timer
      msg.send "쿨매 알림 중지!"

  robot.respond /cool interval ([1-9][0-9]*)/i, (msg) ->
    clearTimeout timer
    oldInterval = interval
    interval = parseInt msg.match[1]
    setTimer interval, msg
    msg.send "쿨매 알림 인터벌 변화: #{oldInterval} -> #{interval}"

  setTimer = (interval, msg) ->
    timer = setTimeout parse, 0, msg, (err) ->
      if not err
        setTimer interval*60*1000, msg
      else
        setTimer 0, msg

  parse = (msg, cb) ->
    msg.http(DIVEDICE_SELLING_LIST_URL)
      .get() (err, res, body) ->
        if err then return cb err
        $ = cheerio.load(body)
        links = $('.board_list .subject').find("img + a").next()

        articles = []
        for link in links
          do (link) ->
            category = $(link).prev().attr('href').split("sca=")[1]

            if category == "%C6%C7%B8%C5"
              article_id = parseInt($(link).attr('href').split('id=')[1])

              if article_id > last_article_checked
                articles.push article_id
                href = DIVEDICE_SELLING_LIST_URL + "&wr_id=#{article_id}"
                robot.http(href)
                  .encoding('binary')
                  .get() (err, res, body) ->
                    bodyUtf8 = convertE2U(body)
                    $ = cheerio.load(bodyUtf8)
                    title = $('.contentsTit').text().split('[판매]')[1].trim()
                    # time = $('.subInfo').text().trim()
                    contents = $("#writeContents")[0]
                    $(contents).find("strike").parent().remove()
                    contents = $(contents).text().trim()
                    msg.send "#{title} [#{href}]\n#{contents}"
        if articles.length > 0
          last_article_checked = articles.sort().reverse()[0]
        cb null

  convertE2U = (binary_euc)->
    buf = new Buffer(binary_euc.length)
    buf.write(binary_euc, 0, binary_euc.length, 'binary')
    return iconv.convert(buf).toString()
