import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	connect() {
        const delay = this.data.get('delay');

        setTimeout(() => {
            this.element.classList.add('hidden');
        }, delay ?? 1000);
    }
}
