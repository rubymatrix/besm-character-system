// app/javascript/controllers/nested_form_controller.js
import { Controller } from "@hotwired/stimulus"

/**
 * Usage:
 * <div data-controller="nested-form"
 *      data-nested-form-wrapper-selector-value="[data-attribute-row]">
 *   <div data-nested-form-target="container"> ... rows ... </div>
 *   <template data-nested-form-target="template" data-template-name="attribute"> ... </template>
 *   <button data-action="nested-form#add" data-nested-form-template-param="attribute">Add</button>
 * </div>
 */
export default class extends Controller {
  static targets = ["container", "template"]
  static values = { wrapperSelector: String }

  add(event) {
    event.preventDefault()
    const name = event.params.template
    const tpl = this.templateTargets.find(t => t.dataset.templateName === name)
    if (!tpl) return
    const html = tpl.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    const fragment = document.createRange().createContextualFragment(html)
    this.containerTarget.appendChild(fragment)
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest(this.wrapperSelectorValue || "[data-row]")
    if (!wrapper) return
    // set hidden _destroy if present, then hide; otherwise just remove for new records
    const destroyField = wrapper.querySelector("[data-nested-form-target='destroyField']")
    if (destroyField) {
      destroyField.value = "1"
      wrapper.style.display = "none"
    } else {
      wrapper.remove()
    }
  }
}