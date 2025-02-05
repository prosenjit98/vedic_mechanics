import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="global-modal"
export default class extends Controller {
  static targets = ["output"]
  
  connect() {
    if (this.hasOutputTarget) {
      const $targetEl = document.getElementById('global_model_id');
      this.modal = new Modal($targetEl, {});
      this.modal.show();
    }
  }

  close(event) {
    this.modal.hide();
  }
}
