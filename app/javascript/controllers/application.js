import { Application } from "@hotwired/stimulus"
import { Autocomplete } from "stimulus-autocomplete"


const application = Application.start()
application.register('autocomplete', Autocomplete)

// 開発中のログと警告を表示させない
application.debug = false
window.Stimulus   = application

export { application }
