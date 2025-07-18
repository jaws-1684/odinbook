import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let mylink = document.getElementById("top-link");
    if (mylink) {
        
    mylink.style.display = "none";

  // When the user scrolls down 20px from the top of the document, show the button
  window.onscroll = function() {scrollFunction()};

  function scrollFunction() {
    if (document.documentElement.scrollTop > 20) {
      mylink.style.display = "block";
    } else {
      mylink.style.display = "none";
    }
  }

  // When the user clicks on the button, scroll to the top of the document
  mylink.addEventListener("click", topFunction)
  function topFunction() {
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
} 
    }
  }

}