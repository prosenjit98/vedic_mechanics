import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
  connect() {    
    const toggleButton = document.getElementById('dark-mode-toggle');
    const bodyElement = document.body;

    // Apply dark mode based on localStorage
    if (localStorage.getItem('theme') === 'dark' || 
        (!localStorage.getItem('theme') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      bodyElement.classList.add('dark');
      console.log('dark mode on ======   for local storage =============================');
    } else {
      bodyElement.classList.remove('dark');
      console.log('dark mode off ===== for local storage ============================');
    }

    // Toggle dark mode on button click
    toggleButton.addEventListener('click', () => {
      bodyElement.classList.toggle('dark');
      // Save the preference in localStorage
      if (bodyElement.classList.contains('dark')) {
        localStorage.setItem('theme', 'dark');
      } else {
        localStorage.setItem('theme', 'light');
      }
    });
    // initializeCarousel()
  }

  // initializeCarousel() {
  //   const carouselElement = document.querySelector('div[data-carousel="static"]');

  //   if (carouselElement) {
  //     // Initialize the carousel
  //     const carousel = new window.Carousel(carouselElement, {
  //       interval: 3000, // Adjust interval as needed
  //       activeClasses: 'bg-green-500', // Customize active classes
  //       inactiveClasses: 'bg-green-300', // Customize inactive classes
  //     });
  
  //     // Optionally add event listeners for controls
  //     document
  //       .querySelector('[data-carousel-prev]')
  //       ?.addEventListener('click', () => carousel.prev());
  //     document
  //       .querySelector('[data-carousel-next]')
  //       ?.addEventListener('click', () => carousel.next());
  //   }
  // }
}
