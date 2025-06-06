import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.body.style.overflow = 'hidden'
  }

  disconnect() {
    document.body.style.overflow = ''
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
}
}