import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['label', 'selectedLabel', 'button'];

    static NO_DISPLAY_CLASSNAME = 'no-display';

    connect() {
        const id = this.data.get('id');

        this.templateImg = document.querySelector(`img#template-${id}`);
    }

    handleSelect() {
        const file = this.buttonTarget.files[0];

        if (file) {
            this.selectedLabelTarget.classList.remove(this.constructor.NO_DISPLAY_CLASSNAME);
            this.labelTarget.classList.add(this.constructor.NO_DISPLAY_CLASSNAME);

            const reader = new FileReader();
            reader.onload = (e) => {
                this.templateImg.src = e.target.result;
                this.templateImg.classList.remove(this.constructor.NO_DISPLAY_CLASSNAME);
            }

            reader.readAsDataURL(file);
        }
    }

    handleClick(event) {
        if (this.buttonTarget.files.length) {
            event.preventDefault();
            this.buttonTarget.value = '';

            this.selectedLabelTarget.classList.add(this.constructor.NO_DISPLAY_CLASSNAME);
            this.labelTarget.classList.remove(this.constructor.NO_DISPLAY_CLASSNAME);
            this.templateImg.classList.add(this.constructor.NO_DISPLAY_CLASSNAME);

            this.templateImg.src = '';
        }
    }
}
