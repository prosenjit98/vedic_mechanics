import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="site-ratings"
export default class extends Controller {
  static targets = ["popup", 'good', 'bad', 'commentHeading', "commentSection", "commentInput"]

  connect() {
    this.commentSectionTarget.classList.add('hidden');
  }

  smileClicked(event){
    const rate = event.currentTarget.dataset.rate;
    this.commentSectionTarget.classList.remove('hidden');
    const rateInput = document.getElementById('rate')
    rateInput.value = rate
    if(rate == 1) this.commentInputTarget.placeholder = "Please suggest how can we improve"
    else this.commentInputTarget.placeholder = "Please suggest how can we improve further"
  }

  submitRating(event) {
    const rate = document.getElementById('rate')?.value
    const comment = document.getElementById('comment')?.value
    const externalUserId = localStorage.getItem("externalUserId")

    const $targetEl = document.getElementById('thank-model');
    const instanceOptions = {
      id: 'thank-model',
      override: true
    };
    const modal = new Modal($targetEl, {}, instanceOptions);
    this.commentSectionTarget.classList.add('hidden');
    if(!rate) return

    fetch("/site_ratings", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ rate, comment, external_user_id: externalUserId }),
    })
      .then((response) => response.json())
      .then((data) => {
        if(data.data){
          this.goodTarget.innerText = "(" + data.data["excellent"] + "%)"
          this.badTarget.innerText = "(" + data.data["bad"] + "%)"
        }
        if (data.message) {
          modal.show();
          setTimeout(() => {
            modal.hide();
          }, 5000);
        }
      })
      .catch((error) => console.error("Error:", error));
  }
}
