import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    this.isOpen = false;
  }

  open() {
    this.modalTarget.classList.remove("hidden");
    this.isOpen = true;
    this.refreshMarkdownEditors();
  }

  close() {
    this.modalTarget.classList.add("hidden");
    this.isOpen = false;
  }

  refreshMarkdownEditors() {
    requestAnimationFrame(() => {
      this.modalTarget.querySelectorAll(".CodeMirror").forEach((editor) => {
        if (editor.CodeMirror) {
          editor.CodeMirror.refresh();
        }
      });
    });
  }

  reset(event) {
    if (event.detail.success) {
      this.close();
      // No need to reset for edit modal usually, but good practice
    }
  }
}
