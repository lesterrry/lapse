import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	static targets = ['title', 'dateStart', 'dateEnd'];

	periodId = Number(this.data.get('id'));

	handleBlur(event) {
		this.element.dispatchEvent(new CustomEvent('periodChanged',
			{
				bubbles: true,
				detail: {
					id: this.periodId,
					field: event.target.dataset.id,
					value: event.target.innerText || new Date(event.target.value)
				}
			}
		));
	}
}
