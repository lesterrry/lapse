import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	static targets = ['field', 'text'];

	connect() {
		this.placeholder = this.data.get('placeholder');

		const src = this.textTarget.innerHTML;

		console.log(src)

		if (!src || src === '<br>') {
			this.textTarget.innerText = this.placeholder;
			this.fieldTarget.value = '';
			this.textTarget.classList.add('empty');
		}

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

	handleChange(event) {
		const src = event.srcElement.innerHTML;

		if (src && src !== '<br>') {
			this.fieldTarget.value = src;
		}
	}

	handleBlur(event) {
		const src = event.srcElement.innerHTML;

		if (!src || src === '<br>') {
			event.srcElement.innerText = this.placeholder;
			this.fieldTarget.value = '';
			event.currentTarget.classList.add('empty');
		} else {
			event.currentTarget.classList.remove('empty');
		}
	}

	handleFocus(event) {
		const field = this.fieldTarget.value;

		if (!field) {
			event.srcElement.innerText = '';
			event.currentTarget.classList.remove('empty');
		}
	}
}
