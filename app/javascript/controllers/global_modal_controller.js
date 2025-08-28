import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="global-modal"
export default class extends Controller {
  static targets = ["output", 'clickShow']
  
  connect() {
    if (this.hasOutputTarget) {
      const $targetEl = document.getElementById('global_model_id');
      this.modal = new Modal($targetEl, {});
      this.modal.show();
    }
    if (this.hasClickShowTarget) {
      const $targetEl = document.getElementById('global_model_id');
      this.modal = new Modal($targetEl, {});
    }
  }

  open() {
    this.modal.show();
  }

  close() {
    this.modal.hide();
  }
}
