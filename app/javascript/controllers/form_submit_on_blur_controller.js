import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "form"];

  // Method triggered when the input is blurred
  submitOnBlur() {
    this.formTarget.requestSubmit(); // Submits the form
  }
}