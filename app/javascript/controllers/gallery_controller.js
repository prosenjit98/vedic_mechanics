import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "modalContent"];

  connect(){
    const $targetEl = document.getElementById('mediaModal');
    const instanceOptions = {
      id: 'mediaModal'
    };
    this.modal = new Modal($targetEl, {}, instanceOptions);
  }

  open(event) {
    event.preventDefault();
    const target = event.currentTarget;
    console.log(target)
    const contentType = target.dataset.type; // 'image' or 'video'
    const src = target.src;

    if (contentType === "image") {
      this.modalContentTarget.innerHTML = `<img src="${src}" class="max-w-full max-h-screen object-contain h-full"/>`;
    } else if (contentType === "video") {
      this.modalContentTarget.innerHTML = `<video src="${src}" controls class="max-w-full max-h-screen object-contain"></video>`;
    }

    this.modal.show();
  }

  close() {
    this.modal.hide();
  }
}
