// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import 'flowbite';
import "controllers"

import "nice-select2"
import "aos";
import "trix"
import "@rails/actiontext"

import jQuery from "jquery"
import AOS from 'aos';
window.jQuery = jQuery
window.$ = jQuery 

document.addEventListener('turbo:load', () => { AOS.init({offset: 300, delay: 100}) });


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
