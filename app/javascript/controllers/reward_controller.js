import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reward"
export default class extends Controller {
  open(event) {
    const itemId = event.currentTarget.dataset.id
    document.getElementById('reward_id').value = itemId;
  }
}