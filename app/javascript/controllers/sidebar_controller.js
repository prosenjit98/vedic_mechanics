import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggle", "children", 'checkbox'];

  connect() {
    this.childrenTargets.forEach((child) => {
      if (!child.classList.contains("hidden")) {
        child.classList.add("hidden");
      }
    });

    this.checkboxTargets.forEach((checkbox) => {
      if (checkbox.checked) {
        this.expandParents(checkbox);
      }
    });
  }

  expandParents(checkbox) {
    let parent = checkbox.closest("[data-controller='sidebar']");
    while (parent) {
      const toggle = parent.querySelector("[data-action='click->sidebar#toggle']");
      if (toggle) {
        const child = parent.querySelector("[data-sidebar-target='children']");
        if (child && child.classList.contains("hidden")) {
          child.classList.remove("hidden");
          toggle.querySelector("svg").classList.add("rotate-180");
        }
      }
      parent = parent.parentElement.closest("[data-controller='sidebar']");
    }
  }

  toggle(event) {
    const index = this.toggleTargets.indexOf(event.currentTarget);
    const child = this.childrenTargets[index];

    if (child) {
      child.classList.toggle("hidden");
      event.currentTarget.querySelector("svg").classList.toggle("rotate-180");
    }
  }
}
