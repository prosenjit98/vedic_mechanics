import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage"]

  connect() {
    let selected_variant = document.querySelector('#selected_variant')
    if(selected_variant) selected_variant.addEventListener('change', this.changeVariant.bind(this))
  }

  changeVariant(event) {
    const selectedVariant = event.target.value
    console.log({selectedVariant})
    if(selectedVariant) {
      console.log(`product_${selectedVariant}`)
      document.getElementById(`product_${selectedVariant}`)?.click();}
  }

  selectImage(event) {
    const imageUrl = event.target.dataset.imageUrl
    console.log({imageUrl})
    this.mainImageTarget.src = imageUrl
    console.log("change triggered")

    // Remove the border from all thumbnails
    document.querySelectorAll('.border-green-500').forEach(el => el.classList.remove('border-green-500'))
    document.querySelectorAll('.border-transparent').forEach(el => el.classList.add('border-transparent'))

    // Add the border to the selected thumbnail
    event.target.classList.add('border-green-500')
    event.target.classList.remove('border-transparent')
  }
}