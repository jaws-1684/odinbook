import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["post_comments"]

  toggle(event) {
    event.preventDefault()
    this.post_commentsTarget.classList.toggle("hidden")
  }
}
