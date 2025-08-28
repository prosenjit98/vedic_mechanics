import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      group: `parent-${this.element.closest('.group').dataset.parentId}`, // Group items by parent_id
      onEnd: this.updateOrder.bind(this),
    });
  }

  updateOrder(event) {
    // const parentId = this.element.closest('.group').dataset.parentId;
    // const ids = Array.from(this.element.children).map(item => item.dataset.id);

    const { newIndex, item } = event;
    const url = item.dataset["url"]

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ position: newIndex }),
    });
  }
}