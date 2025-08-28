import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["results", "item"];

  connect() {
    this.resultsTarget.classList.add("hidden");
  }

  filter(event) {
    const query = event.target.value.toLowerCase();
    this.resultsTarget.classList.remove("hidden");

    this.itemTargets.forEach((item) => {
      const name = item.dataset.name;
      item.style.display = name.includes(query) ? "block" : "none";
    });

    if (!query) {
      this.resultsTarget.classList.add("hidden");
    }
  }

  select(event) {
    const ingredientName = event.target.innerText;
    const ingredientId = event.target.dataset.name;

    // Scroll to the selected ingredient section
    const section = document.getElementById(ingredientId);
    if (section) {
      section.scrollIntoView({ behavior: "smooth", block: "start" });
    }

    // Hide the dropdown and clear the search box
    this.resultsTarget.classList.add("hidden");
    this.element.querySelector("#ingredient-search").value = "";
  }
}
