app_shop.fn.isInWishlist = async function isInWishlist() {
    let query = {
        query: `query{
            shoppingList(ShoppingListInput: {}) {
              products {
                productId
                size
              }
            }
        }`
    }
    
    let id = product_data.product_id
    
    try {
        const response = await fetch('/graphql/v1/', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json',
          },
          body: JSON.stringify(query),
        });
        const dataJson = await response.json();
        let lists = dataJson.data.shoppingList
        let ids = []
        for (let el of lists) {
            for (let element of el.products) {
                ids.push(element.productId)
            }
        }
    
        if (ids.length === 0)  {
            $('#projector_button_basket_fav .icon-heart').addClass('icon-empty_wishlist')
            $('#projector_button_basket_fav .icon-heart').removeClass('icon-heart')
        }
        
        for (let el of ids) {
            if (el == id) {
                $('#projector_button_basket_fav .icon-empty_wishlist').addClass('icon-heart')
                $('#projector_button_basket_fav .icon-empty_wishlist').removeClass('icon-empty_wishlist')
            } else {
                $('#projector_button_basket_fav .icon-heart').addClass('icon-empty_wishlist')
                $('#projector_button_basket_fav .icon-heart').removeClass('icon-heart')
            }
        }
      } catch (error) {
        console.error('AJAX fetchDataGraphQL() Error:', error);
        // return false;
      }
}