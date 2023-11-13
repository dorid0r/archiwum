# Zamiana kolekcji na pojedyncze produkty przy dzieleniu do koszyka
## Jak używać:
1. kod wklejamy w Javascript w komponencie Karta 'produktu - Zestawy / Kolekcje z wariantami'
2. w callbacku znajdują się dwie funkcje, które można dodatkowo wywołać:
Obie funkcje znajdują się w 'Toplayer Dodano do koszyka + projector hotspot 4'
  - app_shop.fn.showBasketDialog();
  ```js
  app_shop.fn.showBasketDialog = function() {
    $('#content #products_associated_zone4').remove();
  const showPreloaderDialog = function() {
    $('#menu_preloader_add').show();
    $('body').dialog({
      'content': $('#menu_preloader_add'),
      'fixed': false,
      'fitToWindow': false,
      'animate': false,
      'width': 746,
      'wrapperClass': 'dialog_wrapper_menu_preloader_add',
      'adaptiveHeight': true,
      'txtCloseButton':'x',
      afterShow: function() {
        const slides = app_shop.vars.view === 1 ? 2 : 4;
        if ($('.dialog_wrapper_menu_preloader_add #products_associated_zone4 .product').length > slides) {
          app_shop.fn.initDialogSlider();
        }
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
      }
    });
  };

  showPreloaderDialog();

  $(document).on('click', '#menu_preloader_add .added__button.--close', function() {
    window.location.reload();
    $('#dialog_close').click();
    return false;
  });
}
  ```
  
  - app_shop.fn.updateTopBasket();
  
```js
app_shop.fn.updateTopBasket = function() {
  menu_basket_cache(false);
}
```
