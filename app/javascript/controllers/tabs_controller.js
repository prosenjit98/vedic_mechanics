import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.initializeTabs();
  }

  initializeTabs() {
    const tabElements = document.querySelectorAll("[data-tabs-toggle]");
    
    tabElements.forEach(tabElement => {
      const tabTargets = tabElement.getAttribute("data-tabs-toggle");
      const tabs = tabElement.querySelectorAll("[role='tab']");

      tabs.forEach(tab => {
        tab.addEventListener("click", () => {
          const selectedTab = tab.getAttribute("data-tabs-target");

          // Hide all tab panels
          document.querySelectorAll(`${tabTargets} > [role="tabpanel"]`).forEach(panel => {
            panel.classList.add("hidden"); // Hide all tab panels by adding the 'hidden' class
          });

          // Deactivate all tabs
          tabs.forEach(t => {
            t.classList.remove(...tabElement.getAttribute("data-tabs-active-classes").split(" "));
            t.classList.add(...tabElement.getAttribute("data-tabs-inactive-classes").split(" "));
            t.setAttribute("aria-selected", "false");
          });

          // Activate the clicked tab and show its content
          tab.classList.add(...tabElement.getAttribute("data-tabs-active-classes").split(" "));
          tab.classList.remove(...tabElement.getAttribute("data-tabs-inactive-classes").split(" "));
          tab.setAttribute("aria-selected", "true");

          const activeTabPanel = document.querySelector(selectedTab);
          if (activeTabPanel) {
            activeTabPanel.classList.remove("hidden"); // Show the active tab content by removing 'hidden'
          }
        });
      });
    });
  }
}