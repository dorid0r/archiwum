# Rozszerzenie standardowej funkcjonalności dodawania do koszyka o działanie na Searchu

![addtobasket](https://github.com/user-attachments/assets/0a534759-c801-4976-965d-54b092673fa6)

## Jak prawidłowo zaimplementować w.w funkcjonalność

1. Composer: `Układ -> Stopka` w komponencie `Hotspoty dodawanie do koszyka` w zakładce Wydzielony Javascript, na dole kodu należy umieścić kod z pliku addToBasket.js
2. Composer: `Lista produktów` w komponencie `Normalny widok` w zakładce `XML/XSLT` należy umieścić kod z pliku addToBasket.xml

## Wyłowanie
Wywołanie należy umieścić w Composer: `Układ -> Stopka` w komponencie `Hotspoty dodawanie do koszyka` w zakładce Wydzielony Javascript

```js
app_shop.run(() => {
app_shop.fn.productListAddToBasket = new ProductListAddToBasketPlugin({
    selector: '#search',
});
}, 'all', '#search');

app_shop.run(() => {
app_shop.fn.productListAddToBasket.init();
}, 'all', '#search', true);
```


#### Zwróć uwagę: 

1. Dla prawidłowego działania w.w funkcjonalnosci z filtrami ajax'owymi do app_shop.run jako 4 argument trzeba przekazać `true`, np.
  ```js
app_shop.run(() => {
app_shop.fn.productListAddToBasket.init();
}, 'all', '#search', true);
  ```

2. Dla prawidłowego działania w.w funkcjonalnosci przy doczytywaniu produktów (InfiniteScroll) w Composer: `Strony -> Lista produktów` 
w komponencie `Lista produktów bez przeładowania strony` w zakładce `Wydzielony JavaScript` należy dodać dodatkowe wyłowanie na końcu metody updateDom(), np.
  
 
  ```js
    app_shop.run(function InfiniteScrollAppShop() {
      app_shop.fn.infiniteScroll = new InfiniteScroll({
        updateDomCallback: () => {
          
          ...

  this.lastProductInView.observe(document.querySelector('#search .product:last-child'));
    document.querySelectorAll('#search .product[data-product_first]').forEach((el) => {
      that.firstProductInView.unobserve(el);
      that.firstProductInView.observe(el);
    });
    
     **app_shop.fn.productListAddToBasket.init();**
    
    if (this.updateDomCallback) this.updateDomCallback();
          }

          ...

        }

        ...

      })

      ...

    }, 'all', '.search_page #paging_setting_bottom .pagination')
  ```
