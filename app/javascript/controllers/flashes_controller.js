import { Controller } from "@hotwired/stimulus"
  ;

export default class extends Controller {
  connect() {
    // window.$("#flash-messages .ui.message").each(function () {
    //   window.$(this).removeClass("hidden");
    //   window.$("body").toast({
    //     class: window.$(this).attr("class"),
    //     displayTime: 10000,
    //     showIcon: false,
    //     closeIcon: true,
    //     message: window.$(this).html(),
    //     position: "top center",
    //     className: {
    //       toast: "ui message floating fluid padding-xy-small",
    //     },
    //   });
    //   window.$(this).remove();
    // });
  }
}
