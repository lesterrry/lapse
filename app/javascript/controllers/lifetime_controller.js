import * as chartjs from 'chart.js';
import { Controller } from '@hotwired/stimulus'

import { generateChart } from 'helpers/generate_chart';

export default class extends Controller {
	static targets = ['canvas'];

	connect() {
		this.periods = JSON.parse(this.data.get('periods'));
		this.selectedYear = Number.parseInt(this.data.get('selectedYear'), 10);

		this.context = this.canvasTarget.getContext('2d');

		this.renderChart();
	}

	disconnect() {
		this.element.removeEventListener('periodChanged', this.handlePeriodChanged);
	}

	renderChart(withAnimation = false) {
		this.chart?.destroy();

		const chartData = generateChart(this.periods, this.selectedYear);

		this.chart = new Chart(this.context, {
			type: 'doughnut',
			data: chartData,
			options: {
				cutout: '70%',
				animation: { duration: withAnimation ? 1000 : 0 },
				rotation: -16,

				plugins: {
					tooltip: {
						position: 'nearest',
						bodyColor: 'black',
						titleColor: 'black',
						titleFont: { weight: 'normal', family: "system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif" },
						backgroundColor: 'white',
						displayColors: false,
						xAlign: 'center',

						filter: (item) => item.label,

						callbacks: {
							label: () => null,
						}
					},
					legend: {
						display: false,
					},
				}
			}
		});
	}

	handlePeriodChanged(event) {
		const { id, field, value } = event.detail;

		let period = this.periods.find(i => i.id === id);
		
		period[field] = value;

		this.renderChart(false);
	}
}
