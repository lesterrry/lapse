import { Controller } from '@hotwired/stimulus'
import { Chart } from 'chart.js';

export default class extends Controller {
	static targets = ['canvas'];

	connect() {
		this.lifetimeData = JSON.parse(this.data.get('data'));

		const context = this.canvasTarget.getContext('2d');

		const chart = new Chart(context, {
			type: 'doughnut',
			data: {
				labels: ['Red', 'Blue', 'Yellow'],
				datasets: [{
					data: [30, 10, 70],
					backgroundColor: ['red', 'green', 'rgba(1,1,1,0)']
				}]
			},
			options: {
				plugins: {
					tooltip: {
						bodyColor: 'black',
						titleColor: 'black',
						titleFont: { weight: 'normal' },
						backgroundColor: 'white',
						displayColors: false,
						xAlign: 'center',

						callbacks: {
							label: () => null
						}
					},
					legend: {
						display: false,
					},			
				}
			}
		});
	}
}
