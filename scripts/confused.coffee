# Description
#   혼세마왕 짤 소환
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   혼란 - 혼세마왕 짤 소환
#
# Author:
#   woongy

images = [
  "https://cdn.mirror.wiki/http://i.imgur.com/W7LlFGY.jpg",
  "http://image.fmkorea.com/files/attach/new/20150908/67077829/173520824/222016076/1fad0cd2ec66e1a851177c8a562dc187.jpg",
  "http://upload2.inven.co.kr/upload/2015/05/11/bbs/i11090677203.jpg",
  "http://upload2.inven.co.kr/upload/2015/08/14/bbs/i12211466375.png"
  ]

module.exports = (robot) ->

  robot.hear /혼란/i, (msg) ->
    msg.send msg.random images
