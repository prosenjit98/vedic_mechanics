// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import 'flowbite';
import "controllers"

import "nice-select2"
import "aos";
import "trix"
import "@rails/actiontext"
import "driver.js";

import jQuery from "jquery"
import AOS from 'aos';
window.jQuery = jQuery
window.$ = jQuery 

document.addEventListener('turbo:load', () => { AOS.init({offset: 300, delay: 100}) });

document.addEventListener("DOMContentLoaded", () => {
  document.body.addEventListener("click", (event) => {
    const link = event.target.closest("a[data-role='delete-link']"); // Target only links with data-role='delete-link'

    if (link) {
      event.preventDefault();

      const confirmMessage = link.dataset.confirm;
      if (confirmMessage && !window.confirm(confirmMessage)) {
        return;
      }

      const url = link.href;
      const csrfToken = document.querySelector("meta[name='csrf-token']").content;

      fetch(url, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": csrfToken,
          "Content-Type": "application/json"
        }
      }).then((response) => {
          if (response.ok) {
            // Handle success (e.g., reload or navigate)
            window.location.reload();
          } else {
            // Handle errors
            alert("Failed to delete. Please try again.");
          }
        })
        .catch(() => {
          alert("An error occurred. Please try again.");
        });
    }
  });
});

function scrollToActiveLink() {
  const activeElement = document.querySelector(".primary_color.active"); // Select the active link
  if (activeElement) {
    activeElement.scrollIntoView({ behavior: "smooth", inline: "center", block: "nearest" });
  }
}
document.addEventListener("DOMContentLoaded", scrollToActiveLink);
document.addEventListener("turbo:load", scrollToActiveLink);
document.addEventListener("turbo:frame-load", scrollToActiveLink);

document.addEventListener("DOMContentLoaded", showHideElement)
document.addEventListener("turbo:load", showHideElement)
document.addEventListener("turbo:frame-load", showHideElement)

function showHideElement(){
  document.querySelectorAll(".ingredient-link").forEach((link) => {
    link.addEventListener("click", () => {
      // Reset styles for all links
      document.querySelectorAll(".ingredient-link").forEach((item) => {
        item.classList.remove("active");
      });
  
      // Highlight the clicked link
      link.classList.add("active");
  
      // Hide all details
      const allDetails = document.querySelectorAll(".ingredient-details");
      allDetails.forEach((detail) => detail.classList.add("hidden"));
  
      // Show the clicked ingredient's detail
      const targetId = link.dataset.id;
      const targetDetail = document.getElementById(`ingredient-${targetId}`);
      if (targetDetail) {
        targetDetail.classList.toggle("hidden");
      }
    });
  });
}

function initializeNiceSelect(){
  var selectElements = document.querySelectorAll("select.selectable");
  selectElements.forEach((element) => {
    var nextSibling = element.nextElementSibling;
    if(nextSibling && nextSibling.classList.contains('nice-select')){
      
    }else{
      NiceSelect.bind(element, {searchable: true});
    }
  });
}


function initializeCarousels() {
  document.querySelectorAll(".carousel-container").forEach((carouselContainer) => {
    const scrollLeft = carouselContainer.closest('.relative').querySelector(".scroll-left");
    const scrollRight = carouselContainer.closest('.relative').querySelector(".scroll-right");

    function updateScrollButtons() {
      const isOverflowing = carouselContainer.scrollWidth > carouselContainer.clientWidth;
      scrollLeft.classList.toggle("hidden", carouselContainer.scrollLeft === 0);
      scrollRight.classList.toggle("hidden", carouselContainer.scrollLeft + carouselContainer.clientWidth >= carouselContainer.scrollWidth);
    }

    // Scroll the carousel left or right
    if (carouselContainer) {
      scrollLeft.addEventListener("click", () => {
        carouselContainer.scrollBy({ left: -carouselContainer.clientWidth, behavior: "smooth" });
      });

      scrollRight.addEventListener("click", () => {
        carouselContainer.scrollBy({ left: carouselContainer.clientWidth, behavior: "smooth" });
      });

      carouselContainer.addEventListener("scroll", updateScrollButtons);
      updateScrollButtons();
      window.addEventListener("resize", updateScrollButtons);
    }
  });
}

document.addEventListener("turbo:load", () => {
  initializeNiceSelect()
});

document.addEventListener("turbo:frame-load", () => {
  initializeNiceSelect()
});

document.addEventListener("DOMContentLoaded", initializeCarousels);
window.initializeNiceSelect = initializeNiceSelect
window.showHideElement = showHideElement
