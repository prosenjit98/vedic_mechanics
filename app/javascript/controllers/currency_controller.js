import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // static targets = ["menu"]; #have to retrieved with currency dropdown
  connect() {
    this.loadSavedCurrency();
    // document.addEventListener("currency:update", this.loadSavedCurrency.bind(this)); #have to retrieved with currency dropdown
  }

  loadSavedCurrency() {
    const savedCurrency = localStorage.getItem("preferredCurrency") || "INR";
    this.applyCurrency(savedCurrency);
    // this.highlightSelectedCurrency(savedCurrency); #have to retrieved with currency dropdown
  }

  applyCurrency(currency) {
    document.documentElement.setAttribute("data-currency", currency);
    this.updatePriceDisplay(currency);
  }


  highlightSelectedCurrency(currency) {
    this.menuTarget.querySelectorAll(".menuitem").forEach(item => {
      item.classList.remove("bg-gray-100", "font-bold");
      if (item.dataset.value === currency) {
        item.classList.add("bg-gray-100", "font-bold");
      }
    });
  }
  

  saveCurrencyPreference(font) {
    localStorage.setItem("preferredCurrency", font);
  }

  select(event) {
    const selectedFont = event.currentTarget.dataset.value;
    this.highlightSelectedCurrency(selectedFont);
    this.applyCurrency(selectedFont);
    this.saveCurrencyPreference(selectedFont);
  }

  updatePriceDisplay(currency) {
    // Add logic to update all displayed prices dynamically.
    const priceElements = document.querySelectorAll(".price");
    priceElements.forEach(element => {
      const amount = parseFloat(element.dataset.amount);
      let formattedPrice = "";
      switch (currency) {
        case "INR":
          formattedPrice = `₹${amount.toFixed(0)}`;
          break;
        case "USD":
          formattedPrice = `$${amount.toFixed(0)}`;
          break;
        case "EUR":
          formattedPrice = `€${amount.toFixed(0)}`;
          break;
      }
      element.textContent = formattedPrice;
    });
  }

}