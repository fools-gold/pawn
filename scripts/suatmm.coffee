# Description
#   지름을 독촉하는 짤 소환
#   (SUATMM = shut up and take my money)
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   (질러|질렀|지르|지름) - 지름 짤 소환
#
# Author:
#   hwidong

images = [
  "http://pds5.egloos.com/pds/200705/30/76/d0020276_08053543.jpg",
  "http://pds26.egloos.com/pds/201306/03/24/e0079724_51abf55b9db9c.jpg",
  "http://cfs12.blog.daum.net/image/33/blog/2008/01/25/13/08/479960a99c301&filename=%EC%A7%88%EB%9F%AC%EB%9D%BC.jpg",
  "http://i.imgur.com/2hHwdiw.jpg",
  "http://image.gmarket.co.kr/gP_rvw/premiumImg/2013/05/25/20130525073010609717.jpg",
  "http://pds25.egloos.com/pds/201404/25/99/c0109099_5359dc2424723.jpg",
  "http://bbs.miwit.com/data/file/bbs_zzal/2943915411_yD1k2SKa_04_sssird.jpg",
  "http://pds26.egloos.com/pds/201501/27/99/c0109099_54c6ecd3b159f.jpg",
  "http://cfile26.uf.tistory.com/image/241EDA4053A339C20E0323",
  "http://pds23.egloos.com/pds/201112/18/19/a0020919_4eeddecc5320f.jpg",
  "http://cfile23.uf.tistory.com/image/174142284D02300A4ADD57",
  "http://file.thisisgame.com/upload/board/2012/10/02/20121002184319_5348.jpg"
  "http://gigglehd.com/zbxe/files/attach/images/262/071/848/c0014712_47214ac1cc9f2.jpg",
  "http://www.amennews.com/news/photo/201104/11133_13410_1021.jpg",
  "http://cfile29.uf.tistory.com/image/263B424B52AB2A9518EA62",
  "http://cfile27.uf.tistory.com/image/11068B37507FD4F53262CF",
  ]

module.exports = (robot) ->

  robot.hear /(질러|질렀|지르|지름)/i, (msg) ->
    msg.send msg.random images
