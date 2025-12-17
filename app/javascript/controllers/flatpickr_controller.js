import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["startDateInput", "endDateInput"]

  connect() {
    // Start date picker
    this.startPicker = flatpickr(this.startDateInputTarget, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      time_24hr: true,
      onChange: (selectedDates) => {
        if (selectedDates.length > 0) {
          // Allow end date, but not before start date
          this.endPicker.set("minDate", selectedDates[0])

          // Optional: auto-fill end date if empty (+30 min)
          if (!this.endDateInputTarget.value) {
            const endDate = new Date(selectedDates[0].getTime() + 30 * 60000)
            this.endPicker.setDate(endDate)
          }
        }
      }
    })

    // End date picker
    this.endPicker = flatpickr(this.endDateInputTarget, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      time_24hr: true,
      allowInput: true
    })
  }
}
