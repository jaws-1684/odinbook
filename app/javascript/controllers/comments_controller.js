import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["post_comments"]
  
  toggle(event) {
    const frame = this.element.querySelector(`turbo-frame[id="${event.target.dataset.turboFrame}"]`)
    
    if (frame && frame.src) {
      frame.innerHTML = ""
      frame.removeAttribute("src")
      event.preventDefault()
    }
  }
}