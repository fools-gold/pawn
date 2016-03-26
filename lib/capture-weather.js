var system = require('system');
var page = require('webpage').create();

page.viewportSize = { width: 568, height: 320 };

page.open('http://m.weather.naver.com/m/main.nhn?regionCode=09215109', function() {
  if (system.args[1] === 'weekly') {
    page.clipRect = page.evaluate(function() {
      var elem = document.getElementsByClassName('sec_bx')[1];
      elem.getElementsByClassName('_WTR_WEEKLY_FCAST')[0].style.display = 'block';
      return elem.getBoundingClientRect();
    });
  } else {
    page.clipRect = page.evaluate(function() {
      document.getElementsByClassName('arrow_box')[0].style.display = 'none';
      document.getElementsByClassName('cue_left')[0].style.display = 'none';
      document.getElementsByClassName('cue_right')[0].style.display = 'none';
      return document.getElementsByClassName('_WTR_MAIN_SPOT')[0].getBoundingClientRect();
    });
  }
  page.render('weather.png');
  phantom.exit();
});
