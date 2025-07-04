import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "link"]

  toggle(event) {
    event.preventDefault()
    this.formTarget.classList.toggle("hidden")
  }
}
