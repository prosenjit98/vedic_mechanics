import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggle", "children", "checkbox"];

  connect() {
    // Initialize the state of the sidebar
    this.checkboxTargets.forEach(input => {
      input.addEventListener("change", () => {
        var next_sibling = input.nextElementSibling;
        if (input.checked) {
          [...document.querySelectorAll('.checkbox_label')].map(x => x.classList.add("text-gray-800", "dark:text-gray-300"));
          [...document.querySelectorAll('.checkbox_label')].map(x => x.classList.remove("text-blue-500"));
          if (next_sibling){
            next_sibling.classList.remove("text-gray-800", "dark:text-gray-300");
            next_sibling.classList.add("text-blue-500");
          }
        }
      });
    });

    // Hide all children elements initially
    this.childrenTargets.forEach((child) => {
      if (!child.classList.contains("hidden")) {
        child.classList.add("hidden");
      }
    });

    // Expand parent categories for any selected checkbox
    this.checkboxTargets.forEach((checkbox) => {
      if (checkbox.checked) {
        this.expandParents(checkbox);
      }
    });
  }

  expandParents(checkbox) {
    // Expand the parent categories for the checked checkbox
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
    // Get the index of the clicked toggle button

    const rootElement = event.currentTarget.closest('[data-is-root="true"]');
    if (rootElement) {
      const parentElement = rootElement.parentNode.parentNode;
      if(parentElement) {
        const siblings = Array.from(parentElement.children).filter(child => child.firstElementChild !== rootElement);
        siblings.forEach(sibling => {
          sibling.firstElementChild?.querySelector("svg")?.classList?.remove("rotate-180"); 
          const child = sibling.querySelector('[data-sidebar-target="children"]')
          if(child) child.classList.add("hidden")
        });
      }
    }
    const index = this.toggleTargets.indexOf(event.currentTarget);
    const child = this.childrenTargets[index];

    if (child) {
      child.classList.toggle("hidden");
      event.currentTarget.querySelector("svg").classList.toggle("rotate-180");
    }
  }
}
