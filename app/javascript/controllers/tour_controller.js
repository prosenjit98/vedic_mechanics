import { Controller } from "@hotwired/stimulus"
import { driver } from "driver.js"
// import "driver.js/dist/driver.css"

export default class extends Controller {
  connect() {
    if (!localStorage.getItem("tour_shown")) {
      this.startTour()
      localStorage.setItem("tour_shown", "true")
    }
  }

  startTour() {
    const tour = driver({
      nextStep: false,
      showProgress: true,
      onHighlightStarted: (element) => {
        const isNavbarStep = (element.id === "google_translate_element") || (element.id === 'add_cart_id');
        if (isNavbarStep) {
          const hamburger = document.querySelector("#mob_nav_btn");
          if (hamburger) {
            hamburger.click();
          }
        }
      },
      steps: [
        {
          element: ".top_bar_background",
          popover: {
            title: "Welcome to Nutri-Vedic!",
            description: "We're glad to have you here. Let's take a quick tour to help you get familiar with the key features.",
          },
        },
        {
          element: "#google_translate_element",
          popover: {
            title: "Choose Your Preferred Language",
            description: "Select the language you're most comfortable with. This helps personalize your experience throughout the app.",
          },
        },
        {
          element: "#login_section",
          popover: {
            title: "Secure Your Access",
            description: "Log in to access your personalized dashboard, manage your settings, and explore all features tailored for you.",
          },
        },
        {
          element: "#add_cart_id",
          popover: {
            title: "Add Your First Product",
            description: "Click here to start adding products to your catalog. You can manage details, pricing, and availability all in one place.",          
          },
        },
        {
          element: "#product_description_id",
          popover: {
            title: "Product Description And Specification",
            description: "Click here to view products details and specification.",          
          },
        },
        {
          element: ".body_background_2",
          popover: {
            title: "You're All Set!",
            description: "You've now seen the key features. Feel free to explore and start building your experience. If you need help, we're always here!",
          }
        }
      ],
    })

    tour.drive()
  }
}

