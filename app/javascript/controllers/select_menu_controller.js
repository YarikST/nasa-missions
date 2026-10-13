import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-menu"
export default class extends Controller {
    static targets = ["input", "label", "option"]

    select(event) {
        const selectedOption = event.currentTarget

        this.inputTarget.value = selectedOption.dataset.value
        this.labelTarget.textContent = selectedOption.dataset.label

        this.optionTargets.forEach((option) => {
            const selected = option === selectedOption
            const check = option.querySelector("[data-select-menu-check]")

            option.classList.toggle(
                "select-menu-option-selected",
                selected
            )

            option.setAttribute("aria-selected", selected.toString())
            check?.classList.toggle("invisible", !selected)
        })

        this.inputTarget.dispatchEvent(
            new Event("change", { bubbles: true })
        )
    }
}