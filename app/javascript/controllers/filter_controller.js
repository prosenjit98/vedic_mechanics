import { Controller } from "@hotwired/stimulus"
// import { initFlowbite } from "flowbite";

export default class extends Controller {
  static targets = ["filterinput", "container", "content", "header"];

  connect() {
    const $targetEl = document.getElementById('product_details_mod');
    const instanceOptions = {
      id: 'product_details_mod'
    };

    this.modal = new Modal($targetEl, {}, instanceOptions);
    this.filterinputTargets.forEach(input => {
      input.addEventListener("click", () => {
        // Remove the class from all labels
        console.log("0000000000")
        document.querySelectorAll(".checkbox_label_2").forEach((label) => {
          label.classList.remove("slogan-yellow");
        });
  
        // Find the corresponding label and add the class
        const label = input.querySelector('.checkbox_label_2');
        if (label) {
          label.classList.add("slogan-yellow");
        }

        // close mobile drawer if open
        const mobileFilter = document.getElementById("mobile_drawer_close");
        if (mobileFilter) {
          mobileFilter.click();
        }
      });
      input.addEventListener("change", this.submitForm.bind(this));
    });
    this.containerTargets.forEach(input => input.classList.add("hidden"))
  }

  submitForm() {
    this.element.requestSubmit();
  }

  open(event) {
    const contentType = event.currentTarget.dataset.modalType;
    const content = event.currentTarget.dataset.modalContent || "No content available.";

    if (contentType === "description") {
      this.headerTarget.innerHTML = "Description"
      this.contentTarget.innerHTML = `<p class="my-2">${content}</p>`;
    } else if (contentType === "specification") {
      this.headerTarget.innerHTML = "Specifications"
      this.contentTarget.innerHTML = `<p class="my-2">${content}</p>`;
    }
    this.modal.show();
    window.showHideElement();
  }

  openReviews(event) {
    const productId = event.target.dataset.productId;
    const reviewsSection = document.getElementById(`reviews_${productId}`);
    console.log({reviewsSection, productId})

    // Show the modal and insert reviews content
    this.containerTarget.classList.remove("hidden");

    if (reviewsSection) {
      this.contentTarget.innerHTML = `${reviewsSection.innerHTML}`;
      // initFlowbite();
    } else {
      this.contentTarget.innerHTML = "<p>No reviews available for this product.</p>";
    }
  }

  close() {
    this.modal.hide();
  }
}