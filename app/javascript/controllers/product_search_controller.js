import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  query() {
    const query = this.inputTarget.value
    fetch(`/products/search?query=${query}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
    .then(response => response.text())
    .then(html => {
      console.log(html)
      const fragment = document.createRange().createContextualFragment(html);
      document.body.appendChild(fragment);
    })
  }

  remove() {
    let targetEle = document.getElementsByClassName('final_product_result')
    if(targetEle.length > 0) {
      targetEle[0].remove()
    }
  }
}