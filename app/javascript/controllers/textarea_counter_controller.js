import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="textarea-counter"
export default class extends Controller {
    static targets = ["source", "counter"]

    connect() {
        this.count()
    }

    count() {
        const currentLength = this.sourceTarget.value.length
        const maxLength = this.sourceTarget.maxLength

        this.counterTarget.textContent = `${currentLength}/${maxLength}`
    }
}