// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "fomantic-ui"
import LocalTime from "local-time"


import "./controllers"
import "./channels"

$(document).on('turbo:load', function (e) {
  console.log("turbo:load", e);

  init();

});

$(document).on('turbo:frame-load', function (e) {
  console.log("turbo:frame-load", e);
  let frame = e.target
  init(frame);
});

const init = function (context) {
  console.log("init context", context);
  LocalTime.start();

  function select_with_context(selector) {
    if (!context) {
      context = 'body'
    }
    return $(context).find(selector);
  }

  const $$ = select_with_context;

  $$('#rangestart').calendar({
    minTimeGap: 15,
    endCalendar: $$('#rangeend'),
    selectAdjacentDays: true,
    type: 'datetime'
  });

  $$('#rangeend').calendar({
    minTimeGap: 15,
    selectAdjacentDays: true,
    startCalendar: $$('#rangestart'),
    type: 'datetime'
  });

  $$(".dropdown").dropdown();

  $$(".dropdown.additions").dropdown({
    allowAdditions: true,
    hideAdditions: false,
    className: {
      addition: 'stuck addition'
    }
  });

}
