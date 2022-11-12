import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer";

import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';

import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import resourceTimeGridPlugin from '@fullcalendar/resource-timegrid';




// Connects to data-controller="calendar"
export default class extends Controller {

  static targets = ["calendar"]

  connect() {
    this.initCalendar()
    this.initSubscription()

  }

  initSubscription() {

    let $this = this;
    this.subscription = consumer.subscriptions.create('CalendarChannel', {
      connected() {
        console.log('connected to calendar channel');
      },

      disconnected() { },

      received(data) {
        console.log("received", data);
        $this.calendar.refetchEvents()
      }

    });
  }



  initCalendar() {
    this.calendar = new Calendar(this.calendarTarget, {
      allDaySlot: false,
      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
      plugins: [
        dayGridPlugin,
        timeGridPlugin,
        listPlugin,
        interactionPlugin,
        resourceTimeGridPlugin
      ],
      customButtons: {
        myCustomButton: {
          text: 'custom!',
          click: function () {
            alert('clicked the custom button!');
          }
        }
      },
      editable: true,
      selectable: true,
      select: this.selectCallback.bind(this),
      eventClick: this.eventClick.bind(this),
      eventDrop: this.eventDrop.bind(this),
      eventResize: this.eventDrop,
      events: 'events.json',
      eventBackgroundColor: "rgba(255,255,255,0.75)",
      eventTextColor: "rgba(0,0,0,0.8)",
      eventBorderColor: "rgba(0,0,0,.2)",
      eventDidMount: function (info) {
        info.event.extendedProps.groups.forEach(function (group) {
          $(info.el).find('.fc-event-title-container').append(`
            <label class="ui mini icon label" style="color: ${group.color};">
              <i class='icon ${group.icon}'"></i> ${group.name}
            </label>
          `);
        });


        $(info.el).find('.fc-event-title-container')
          .append(
            `<div class="padding-xy-mini">${info.event.extendedProps.description}</div>`
          )

      },
      dateClick: this.dateClick,
      headerToolbar: {
        center: 'title',
        left: 'prev,next today',
        right: 'dayGridMonth,timeGridWeek,resourceTimeGridDay'
      },
      resources: 'locations.json',
      resourceLabelDidMount(info) {
        $(info.el).find('.fc-col-header-cell-cushion').prepend(`
          <i class="icon ${info.resource.extendedProps.icon}"></i>
        `).css('color', info.resource.extendedProps.color);
      },
      height: '100vh',
      initialView: 'resourceTimeGridDay',
      slotDuration: '00:15:00',
      // slotMinTime: '00:10:00'
    });

    window.calendar = this.calendar

    this.calendar.render()
  }



  newEvent(start_time, end_time, resource) {
    let src = `events/new?event[start_time]=${start_time}&event[end_time]=${end_time}&flyout=true`;
    if (resource) {
      src += `&event[location_ids][]=${resource.id}`
    }
    $('#flyout')[0].src = src;
  }

  selectCallback(info) {
    let start_time = info.start
    let end_time = info.end
    let resource = info.resource
    this.newEvent(start_time, end_time, resource)
  }

  dateClick(info) {
    //open the event form in a flyout
    let start_time = info.date
    start_time.setHours(8)

    let end_time = new Date(start_time)
    end_time.setHours(9)
    let frame_src = `events/new?flyout=true&event[start_time]=${start_time}&event[end_time]=${end_time}`

    if (info.resource) {
      frame_src += `&event[location_ids][]=${info.resource.id}`
    }

    $('#flyout')[0].src = frame_src;
  }

  eventDrop(info) {
    //update the event with an api call
    console.log(info);

    let eventParams = {
      start_time: info.event.start,
      end_time: info.event.end,
    }

    if (info.newResource) {
      eventParams.location_ids = [info.newResource.id]
    }

    $.ajax({
      url: 'events/' + info.event.id,
      type: 'PUT',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        event: eventParams
      })
    });
  }

  eventClick(info) {
    info.jsEvent.preventDefault(); // don't let the browser navigate

    if (info.event.url) {
      $('#flyout')[0].src = `${info.event.url}/flyout`;
    }
  }

}