import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flyout"
export default class extends Controller {

  static targets = ["flyout"]


  connect() {
    console.log("Connected to flyout controller");
    $("#flyout").flyout({

    }).flyout('show');

    this.rewriteLinks();
    this.rewriteForms();
  }

  disconnect() {
    $("#flyout").flyout('hide')
  }

  rewriteForms() {
    //add a hidden field to all forms with name flyout and value true
    $(this.element).find('form').each(function () {
      $(this).append('<input type="hidden" name="flyout" value="true">')
    });
  }

  rewriteLinks() {

    $(this.element).find('a').each(function () {
      //append flyout=true to all links
      var href = $(this).attr('href');
      if (href.indexOf('?') > -1) {
        href += '&flyout=true';
      } else {
        href += '?flyout=true';
      }
      $(this).attr('href', href);
    });
  }



}
