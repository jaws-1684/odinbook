import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  copy(event) {
    event.preventDefault()
    const para = document.querySelector('#copy-result')
    const elementcontainer = event.target.parentElement;

    let data = elementcontainer.querySelector('#value') 
    navigator.clipboard.writeText(data.textContent);

    para.textContent = "Copied"
    }
  
}