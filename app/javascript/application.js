// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "fomantic-ui"


$(document).on('turbo:load', function () {
  $(".dropdown").dropdown();
});



$(document).on('turbo:frame-load', function () {
  $('#rangestart').calendar({
    type: 'datetime',
    endCalendar: $('#rangeend')
  });
  $('#rangeend').calendar({
    type: 'datetime',
    startCalendar: $('#rangestart')
  });

});