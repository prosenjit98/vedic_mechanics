import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    window.addEventListener("scroll", this.toggleButton.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.toggleButton.bind(this));
  }

  toggleButton() {
    if (window.scrollY > 300) {
      this.buttonTarget.classList.remove("hidden");
    } else {
      this.buttonTarget.classList.add("hidden");
    }
  }

  scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
}
