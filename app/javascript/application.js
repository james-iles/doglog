// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


$(document).ready(function() {
  $(".datepicker").flatpickr({
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    minDate: "today",
    time_24hr: true
  });
});

$(document).ready(function() {
  $("#calendar").fullCalendar();
});

import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'

const calendar = new Calendar(calendarEl, {
  plugins: [dayGridPlugin],
  initialView: 'dayGridMonth'
});
