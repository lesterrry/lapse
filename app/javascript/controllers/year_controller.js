import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	connect() {
		const periods = JSON.parse(this.data.get('periods'));
		
	}
}