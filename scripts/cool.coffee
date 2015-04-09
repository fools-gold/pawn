# Description
#   Notify cool boardgame selling articles at divedice
#
# Dependencies:
#   "cheerio"
#
# Configuration:
#   None
#
# Commands:
#   Not needed
#
# Author:
#   hwidong

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /cool/i, (msg) ->
    msg.http("http://www.divedice.com/shop/gboard/bbs/board.php?bo_table=mkt")
      .get() (err, res, body) ->
        $ = cheerio.load(body)
        links = $('.board_list .subject').find("img + a").next()
        for link in links
          do (link) ->
            category = $(link).prev().attr('href').split("sca=")[1]
            if category == "%C6%C7%B8%C5"
              article_id = $(link).attr('href').split('id=')[1]
              href = "http://www.divedice.com/shop/gboard/bbs/board.php?bo_table=mkt&wr_id=#{article_id}"
              robot.http(href)
                .get() (err, res, body) ->
                  $ = cheerio.load(body)
                  title = $('.contentsTit').text().split('[판매]')[1].trim()
                  time = $('.subinfo').text()
                  contents_arr = $("#writeContents div").filter(function() {return $( "strike", this ).length === 0 && $(this).children().length > 0})
                  contents = ""
                  contents_arr.each(function(){contents += $(this).text() + "\n"})
                  msg.send "#{title} [${time}]\n${contents}"
