import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown"]

  toggle(event) {
    event.preventDefault()
    this.dropdownTarget.classList.toggle("hidden")
  }

  closeBackground(event) {
    if (event && !this.dropdownTarget.contains(event.target)) {
      this.toggle()
    }
  }
}
