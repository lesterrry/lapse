import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	static targets = ['field'];

	connect() {
		window.addEventListener('keydown', this.handleKeyDown.bind(this));
	}

	disconnect() {
		window.removeEventListener('keydown', this.handleKeyDown.bind(this));
	}

	handleKeyDown(event) {
		// disabling enter key
		if (event.keyCode === 13) {
			event.preventDefault();
			return false;
		}
	}

	handleBlur(event) {
		this.fieldTarget.value = event.srcElement.innerHTML;
	}
}
