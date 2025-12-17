import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import rangePlugin from "flatpickrRangePlugin";

export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput' ]

  connect() {
    flatpickr(this.startDateInputTarget, {
      enableTime: true,        // Enable time selection
      dateFormat: "Y-m-d H:i", // Format: 2024-12-16 14:30
      time_24hr: true,         // Use 24-hour format
      "plugins": [new rangePlugin({ input: this.endDateInputTarget})]
    })
  }
}
