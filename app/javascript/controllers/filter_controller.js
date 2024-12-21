import { Controller } from "@hotwired/stimulus"
// import { initFlowbite } from "flowbite";

export default class extends Controller {
  static targets = ["filterinput", "container", "content"];

  connect() {
    this.filterinputTargets.forEach(input => {
      input.addEventListener("click", () => {
        // Remove the class from all labels
        console.log({input})
        console.log({"id": input.id})
        document.querySelectorAll(".checkbox_label_2").forEach((label) => {
          label.classList.remove("text-green-600", "font-bold");
        });
  
        // Find the corresponding label and add the class
        const label = input.querySelector('.checkbox_label_2');
        if (label) {
          label.classList.add("text-green-600", "font-bold");
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
    console.log("Open modal");
    this.containerTarget.classList.remove("hidden");
    const contentType = event.currentTarget.dataset.modalType;
    const content = event.currentTarget.dataset.modalContent || "No content available.";

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
      // initFlowbite();
    } else {
      this.contentTarget.innerHTML = "<p>No reviews available for this product.</p>";
    }
  }

  close() {
    this.containerTarget.classList.add("hidden");
  }
}