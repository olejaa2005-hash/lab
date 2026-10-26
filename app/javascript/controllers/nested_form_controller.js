import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["target", "template"]

    add(event) {
        event.preventDefault()

        // Замінюємо шаблонний індекс на мілісекунди
        const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())

        // Вставляємо нові поля безпосередньо перед цільовим контейнером або в нього
        this.targetTarget.insertAdjacentHTML('beforebegin', content)
    }

    remove(event) {
        event.preventDefault()
        const wrapper = event.target.closest('.nested-fields')

        if (wrapper.dataset.newRecord === "true") {
            wrapper.remove()
        } else {
            wrapper.style.display = 'none'
            const destroyInput = wrapper.querySelector("input[name*='_destroy']")
            if (destroyInput) destroyInput.value = "1"
        }
    }
}