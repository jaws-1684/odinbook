import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
   let body = document.body;
   let turboResults = document.querySelector(".b-search");
   body.addEventListener("click", (event) => {

      if (!turboResults.contains(event.target)) {
      turboResults.parentElement.removeAttribute("src")
      turboResults.remove()
      }
    })
  }

  hide() {
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
}
}