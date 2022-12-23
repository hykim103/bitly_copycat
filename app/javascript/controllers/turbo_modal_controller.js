import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets= ["modal", "window"]
  connect() {
    console.log("turbo-modal-controller is connected!")

  }

  modal = this.modalTarget

  open() {
    console.log(this.modalTarget)
    modal.style.display = "block"
  }

  close() {
    console.log(this.modalTarget)
    modal.style.display = "none"
  }
}

window.onclick = function(event) {
  console.log(event.target)
  if (event.target == modal) {

    modal.style.display = "none";
  }
}
