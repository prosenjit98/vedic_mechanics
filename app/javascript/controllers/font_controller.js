import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];
  connect() {
    this.loadSavedFont();
    // const savedFont = localStorage.getItem("preferredFont") || "google-sans"; ``
    // this.element.value = savedFont;
    // document.body.className = savedFont;
    // this.element.addEventListener("change", this.changeFont);
  }

  loadSavedFont() {
    const savedFont = localStorage.getItem("preferredFont") || "google-sans";
    this.applyFont(savedFont);
    this.highlightSelectedFont(savedFont);
  }

  applyFont(font) {
    document.body.className = ""; // Clear any existing font classes
    document.body.classList.add(font);
  }

  highlightSelectedFont(font) {
    this.menuTarget.querySelectorAll(".menuitem").forEach(item => {
      item.classList.remove("bg-gray-100", "font-bold");
      if (item.dataset.value === font) {
        item.classList.add("bg-gray-100", "font-bold");
      }
    });
  }
  

  saveFontPreference(font) {
    localStorage.setItem("preferredFont", font);
  }

  select(event) {
    const selectedFont = event.currentTarget.dataset.value;
    this.highlightSelectedFont(selectedFont);
    this.applyFont(selectedFont);
    this.saveFontPreference(selectedFont);
  }

  changeFont(event) {
    const selectedFont = event.target.value;
    document.body.className = ""; // Clear existing font classes
    document.body.classList.add(selectedFont);
    localStorage.setItem("preferredFont", selectedFont);
  }
}