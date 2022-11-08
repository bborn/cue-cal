// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "fomantic-ui"


$(document).on('turbo:load', function () {

  $(".dropdown").dropdown();
});