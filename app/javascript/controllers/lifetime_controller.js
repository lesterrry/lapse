import { Controller } from '@hotwired/stimulus'
import { Chart } from 'chart.js';

import { generateChart } from '../helpers/generateChart';

export default class extends Controller {
	static targets = ['canvas'];

	connect() {
		const periods = JSON.parse(this.data.get('periods'));

		const context = this.canvasTarget.getContext('2d');

		const chartData = generateChart(periods);

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
