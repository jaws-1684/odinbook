import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  hide() {
     this.element.parentElement.removeAttribute("src")
    this.element.remove()
}
}