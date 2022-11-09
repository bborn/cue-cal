import { Controller } from "@hotwired/stimulus"

import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';

import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';

// Connects to data-controller="calendar"
export default class extends Controller {

  static targets = ["calendar"]

  connect() {
    let calendar = new Calendar(this.calendarTarget, {
      plugins: [
        dayGridPlugin,
        timeGridPlugin,
        listPlugin,
        interactionPlugin
      ],
      editable: true,
      eventClick: this.eventClick,
      eventDrop: this.eventDrop,
      events: '/events.json',
      headerToolbar: {
        center: 'title',
        left: 'prev,next today',
        right: 'dayGridMonth,timeGridWeek,listWeek'
      },
      height: '80vh',
      initialView: 'dayGridMonth',
    });

    window.calendar = calendar

    calendar.render()
  }

  eventDrop(info) {
    //update the event with an api call
    $.ajax({
      url: '/events/' + info.event.id,
      type: 'PUT',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        event: {
          start_time: info.event.start,
          end_time: info.event.end
        }
      })
    });
  }

  eventClick(info) {
    info.jsEvent.preventDefault(); // don't let the browser navigate

    if (info.event.url) {
      $('#flyout')[0].src = `${info.event.url}?flyout=true`;
    }
  }

}