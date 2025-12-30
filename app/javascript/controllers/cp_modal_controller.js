import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log("CP Modal Connected");
    // Ensure modal is hidden on connect
    if (!this.modalTarget.classList.contains("hidden")) {
      this.modalTarget.classList.add("hidden");
    }
  }

  open(event) {
    event.preventDefault();
    this.modalTarget.classList.remove("hidden");
  }

  close(event) {
    if (event) event.preventDefault();
    this.modalTarget.classList.add("hidden");
  }
}
