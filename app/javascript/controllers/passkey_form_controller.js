import { Controller } from '@hotwired/stimulus'

import {
	startConditionalMediation,
	submitFormEvent as submitSessionFormEvent
} from 'session_form'

import {
	submitFormEvent as submitRegistrationFormEvent
} from 'registration_form'

export default class extends Controller {
	static targets = ['form'];

	formType = this.data.get('type')

	connect() {
		if (this.formType === 'session') {
			startConditionalMediation(this.formTarget);
			this.formTarget.addEventListener('submit', submitSessionFormEvent);
		} else if (this.formType === 'registration') {
			this.formTarget.addEventListener('submit', submitRegistrationFormEvent);
		}
	}
}
