# Description
#   Funny ascii arts
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot ascii list - Shows the list of all ascii arts available
#
# Author:
#   woongy

module.exports = (robot) ->

  robot.respond /ascii list/i, (msg) ->
    msg.send "두둠칫"

  robot.hear /두둠칫/i, (msg) ->
    name = msg.match[1]
    msg.send """
⊂_＼
　 ＼＼ Λ＿Λ
　　 ＼( ‘ㅅ' ) 두둠칫
　　　 >　⌒＼
　　　/ 　 へ＼
　　 /　　/　＼＼
　　＼　ノ　　＼_つ
　　/　/  두둠칫
　 /　/|
　(　(＼
　|　|、＼
　| 丿 ＼ ⌒)
　| |　　) /
`ノ )　　Lノ
"""
