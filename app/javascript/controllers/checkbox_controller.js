import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	static targets = ['label'];

    connect() {
        this.textChecked = this.data.get('textChecked');
        this.textUnchecked = this.data.get('textUnchecked');

        console.log(this.textChecked, this.data)
    }

	handleChange(event) {
		console.log(event.target.checked)
        this.labelTarget.textContent = event.target.checked ? this.textChecked : this.textUnchecked;
	}
}
