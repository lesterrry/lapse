import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	static targets = ['destination']

	connect() {
		window.addEventListener("keydown", this.handleKeyDown.bind(this))
	}

	disconnect() {
		window.removeEventListener("keydown", this.handleKeyDown.bind(this))
	}

	handleKeyDown(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			return false;
		}
	}


	rewrite(event) {
		this.destinationTarget.value = event.srcElement.innerHTML;
	}
}