import { Controller } from "@hotwired/stimulus"

const $ = window.jQuery

// Connects to data-controller="popup-edit"
export default class extends Controller {
  connect() {
    console.log(this.element);
    $(this.element).popup({
      on: "click",
      inline: false,
      exclusive: true,
      movePopup: true,
      closable: true
    })
  }
}
