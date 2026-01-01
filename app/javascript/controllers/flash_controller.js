import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        // Auto-dismiss after 5 seconds
        setTimeout(() => {
            this.dismiss();
        }, 5000);
    }

    dismiss() {
        this.element.classList.add("opacity-0", "translate-y-[-20px]");
        setTimeout(() => {
            this.element.remove();
        }, 300);
    }
}
