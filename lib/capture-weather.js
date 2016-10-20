var system = require('system');
var page = require('webpage').create();

page.viewportSize = { width: 568, height: 320 };

page.open('http://m.weather.naver.com/m/main.nhn?regionCode=09215109', function() {
  if (system.args[1] === 'weekly') {
    page.clipRect = page.evaluate(function() {
      return document.getElementsByClassName('card_weekly')[0].getBoundingClientRect();
    });
  } else {
    page.clipRect = page.evaluate(function() {
      document.getElementsByClassName('pagination')[0].style.display = 'none';
      document.getElementsByClassName('flick_nav')[0].style.display = 'none';
      document.getElementsByClassName('section_location')[0].style.display = 'none';
      return document.getElementsByClassName('card_now')[0].getBoundingClientRect();
    });
  }
  page.render('weather.png');
  phantom.exit();
});
