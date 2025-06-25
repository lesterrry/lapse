import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['menu']

  connect() {
    // Close dropdown when clicking outside
    document.addEventListener('click', this.closeIfClickedOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener('click', this.closeIfClickedOutside.bind(this))
  }

  toggle(event) {
    event.stopPropagation()
    const menu = this.element.querySelector('.dropdown-menu')
    menu.classList.toggle('show')
  }

  closeIfClickedOutside(event) {
    if (!this.element.contains(event.target)) {
      const menu = this.element.querySelector('.dropdown-menu')
      if (menu && menu.classList.contains('show')) {
        menu.classList.remove('show')
      }
    }
  }
}