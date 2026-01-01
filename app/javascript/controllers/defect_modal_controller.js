import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    this.isOpen = false;
  }

  open() {
    this.modalTarget.classList.remove("hidden");
    this.isOpen = true;
  }

  close() {
    this.modalTarget.classList.add("hidden");
    this.isOpen = false;
  }
}
