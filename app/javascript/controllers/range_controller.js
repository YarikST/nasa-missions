import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  static targets = ["counter"]

  count(event) {
    this.counterTarget.textContent = event.currentTarget.valueAsNumber
  }
}