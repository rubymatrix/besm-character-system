import { Controller } from "@hotwired/stimulus";
import EasyMDE from "easymde";

// Connects to data-controller="markdown-editor"
export default class extends Controller {
  connect() {
    this.editor = new EasyMDE({
      element: this.element,
      forceSync: true,
      spellChecker: false,
      status: false,
      toolbar: [
        "bold",
        "italic",
        "heading",
        "|",
        "quote",
        "unordered-list",
        "ordered-list",
        "|",
        "link",
        "image",
        "|",
        "preview",
        "side-by-side",
        "fullscreen",
        "|",
        "guide",
      ],
    });
  }

  disconnect() {
    if (this.editor) {
      this.editor.toTextArea();
      this.editor.cleanup();
      this.editor = null;
    }
  }
}
