import { Controller } from "@hotwired/stimulus"

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import { Turbo } from "@hotwired/turbo-rails";
// import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="calendar"
export default class extends Controller {

  static targets = ["calendar"]

  connect() {
    console.log(this.calendarTarget)
    let calendar = new Calendar(this.calendarTarget, {
      eventClick: this.eventClick,
      events: '/events.json',
      headerToolbar: {
        center: 'title',
        left: 'prev,next today',
        right: 'dayGridMonth,timeGridWeek,listWeek'
      },
      height: '80vh',
      initialView: 'dayGridMonth',
      plugins: [dayGridPlugin, timeGridPlugin, listPlugin],
      timeZone: 'UTC'
    });

    calendar.render()


  }

  eventClick(info) {

    info.jsEvent.preventDefault(); // don't let the browser navigate

    if (info.event.url) {
      $('#flyout')[0].src = `${info.event.url}/flyout`;
      // Turbo.visit(`${info.event.url}/flyout`);
      $('#flyout').flyout('show');
    }
  }

}