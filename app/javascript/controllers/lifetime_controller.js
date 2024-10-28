import { Controller } from "@hotwired/stimulus"
import { Chart } from 'chart.js';

export default class extends Controller {
	static targets = ['canvas'];

	connect() {
		this.lifetimeData = JSON.parse(this.data.get('data'));

		this.context = this.canvasTarget.getContext('2d');

		this.chart = new Chart(this.context, {
			type: 'pie',
			data: {
				labels: ['Red', 'Blue', 'Yellow', 'Green'],
				datasets: [{
					data: [10, 20, 30, 40],
					backgroundColor: ['red', 'blue', 'yellow', 'green']
				}]
			},
			options: {}
		});
	}
}
