import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	connect() {
		this.periodId = Number(this.data.get('id'));
	}

	handleBlur(event) {
		this.element.dispatchEvent(new CustomEvent('periodChanged',
			{
				bubbles: true,
				detail: {
					id: this.periodId,
					field: event.target.dataset.id,
					value: event.target.innerText || (event.target.type === 'date' ? new Date(event.target.value) : event.target.value)
				}
			}
		));
	}
}
