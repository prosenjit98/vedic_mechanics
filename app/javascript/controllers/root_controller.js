import { Controller } from "@hotwired/stimulus"
import { v4 as uuid_v4 } from 'uuid';

export default class extends Controller {
  static targets = ["user", "link", "categoryBar", "searchBar"]
  connect() {
    console.log("connected root")
    this.ensureExternalUserId()
  }
  ensureExternalUserId() {
    let externalUserId
    if(this.hasUserTarget){
      externalUserId = this.userTarget.dataset.externalId
      if(externalUserId != undefined) {
        let pre_externalUserId = localStorage.getItem("externalUserId");
        this.updateCartStorage(externalUserId)
        if(pre_externalUserId != externalUserId){
          localStorage.setItem("externalUserId", externalUserId)
          this.updateCartStorage(externalUserId)
        }
      }
    }else{
      externalUserId = localStorage.getItem("externalUserId")
      if (!externalUserId) {
        externalUserId = uuid_v4()
        localStorage.setItem("externalUserId", externalUserId)
      }
    }
    if(this.hasLinkTarget){
      this.updateHref(externalUserId)
    }

  }

  updateCartStorage(externalUserId){
    fetch(`/carts/get_cart_details?external_user_id=${externalUserId}`)
    .then(response => response.json())
    .then(data => {
      if(data?.cart_items?.length > 0){
        localStorage.setItem("cart", JSON.stringify(data.cart_items))
      }else{
        localStorage.removeItem("cart")
      }
      // let el = document.getElementById('cart-count-id')
      // const controller = this.application.getControllerForElementAndIdentifier(el, 'cart')
      // controller.updateCartCount();
      })
    .catch(error => {
      console.error('Error:', error);
    })
  }

  updateHref(externalUserId) {
    this.linkTargets.forEach(link => {
      console.log({link})
      const url = new URL(link.href);
      console.log({url})
      url.searchParams.set('external_id', externalUserId); // Add or update query parameter
      link.href = url.toString();
    });
  }

  showSearch() {
    this.searchBarTarget.classList.remove("hidden");
    this.categoryBarTarget.classList.add("hidden");
  }

  closeSearch(){
    this.searchBarTarget.classList.add("hidden");
    this.categoryBarTarget.classList.remove("hidden");
  }
  
}
