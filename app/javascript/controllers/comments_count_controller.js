import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["countComments"]

  count() {
    this.countCommentsTarget.textContent = 2
  }
}
