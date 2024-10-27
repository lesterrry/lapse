import { Controller } from "@hotwired/stimulus"
import { Chart } from 'chart.js';

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
