import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput' ]

  connect() {
    this.startPicker = flatpickr(this.startDateInputTarget, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      time_24hr: true,
      onChange: (selectedDates) => {
        if (selectedDates[0] && this.endPicker) {
          this.endPicker.set('minDate', selectedDates[0])
        }
      }
    })

    this.endPicker = flatpickr(this.endDateInputTarget, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      time_24hr: true
    })
  }

  disconnect() {
    if (this.startPicker) this.startPicker.destroy()
    if (this.endPicker) this.endPicker.destroy()
  }
}
