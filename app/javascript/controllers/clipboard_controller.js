import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  copy(event) {
    event.preventDefault()
    const container = event.target.parentElement;
    let data = container.querySelector('#value')
  
    
     navigator.clipboard.writeText(data.textContent);

    }
  
}