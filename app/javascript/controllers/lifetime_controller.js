import { Controller } from '@hotwired/stimulus'
import { Chart } from 'chart.js';

import { generateChart } from '../helpers/generate_chart';

export default class extends Controller {
	static targets = ['canvas'];

	connect() {
		const periods = JSON.parse(this.data.get('periods'));
		const selectedYear = Number.parseInt(this.data.get('selectedYear'), 10);

		console.log(selectedYear);

		const context = this.canvasTarget.getContext('2d');

		const chartData = generateChart(periods, selectedYear);

		const chart = new Chart(context, {
			type: 'doughnut',
			data: chartData,
			options: {
				cutout: '70%',

				plugins: {
					tooltip: {
						position: 'nearest',
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
