var page = require('webpage').create();

page.viewportSize = { width: 568, height: 320 };
page.clipRect = { top: 126, left: 0, width: page.viewportSize.width, height: 434 };

page.open('http://m.weather.naver.com/m/main.nhn?regionCode=09215109', function() {
  page.render('weather.png');
  phantom.exit();
});
