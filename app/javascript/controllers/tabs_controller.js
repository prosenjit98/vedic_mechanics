import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["prev", "next", "indicator"];

  connect() {
    this.updateButtonStates();
  }

  prevBtn() {
    this.updateButtonStates();
  }

  nextBtn() {
    this.updateButtonStates();
  }

  getCurrentSlideIndex() {
    return this.indicatorTargets.findIndex((button) =>
      button.getAttribute("aria-current") === "true"
    );
  }

  updateButtonStates() {
    const currentIndex = this.getCurrentSlideIndex();
    this.prevTarget.disabled = currentIndex === 0;
    this.nextTarget.disabled = currentIndex === this.indicatorTargets.length - 1;
  }
}