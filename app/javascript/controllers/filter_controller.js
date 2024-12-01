import { Controller } from "@hotwired/stimulus"
// import { initFlowbite } from "flowbite";

export default class extends Controller {
  static targets = ["filterinput", "container", "content"];

  connect() {
    this.filterinputTargets.forEach(input => {
      input.addEventListener("change", this.submitForm.bind(this));
    });
    this.containerTargets.forEach(input => input.classList.add("hidden"))
  }

  submitForm() {
    this.element.requestSubmit();
  }

  open(event) {
    console.log("Open modal");
    this.containerTarget.classList.remove("hidden");
    const contentType = event.target.dataset.modalType;
    const content = event.target.dataset.modalContent || "No content available.";

    if (contentType === "description") {
      this.contentTarget.innerHTML = `<strong>Description:</strong> <p>${content}</p>`;
    } else if (contentType === "specification") {
      this.contentTarget.innerHTML = `<strong>Specifications:</strong> <p>${content}</p>`;
    }
  }

  openReviews(event) {
    const productId = event.target.dataset.productId;
    const reviewsSection = document.getElementById(`reviews_${productId}`);
    console.log({reviewsSection, productId})

    // Show the modal and insert reviews content
    this.containerTarget.classList.remove("hidden");

    if (reviewsSection) {
      this.contentTarget.innerHTML = `${reviewsSection.innerHTML}`;
      initFlowbite();
    } else {
      this.contentTarget.innerHTML = "<p>No reviews available for this product.</p>";
    }
  }

  close() {
    this.containerTarget.classList.add("hidden");
  }
}