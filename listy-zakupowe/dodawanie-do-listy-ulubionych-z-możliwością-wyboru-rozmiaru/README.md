# Dodawanie do listy ulubionych z możliwością wyboru rozmiaru

![REC-20240304133426](https://github.com/stipula/case-study/assets/32408896/8aa9f6c9-cfba-4d54-b369-39ad04351872)

## Jak prawidłowo zaimplementować w.w funkcjonalność

1. Composer: `Układ -> Stopka` w komponencie `Lista zakupowa - Javascript + CSS + XSLT` w zakładce `Ustawienia` należy usunąć z listy `Wybierz strony, na których komponent ma być ukryty` strony na których chcemy, żeby działał Standardowy mechanizm dodawania do listy ulubionych, który jest niezbędny dla prawidłowego działania funkcjonalności opisanej na tej podstronie. Dla działania na hotpsotach na mainie będzie do usunięcia - `strona główna`, dla działania na searchu będzie do usunięcia - `lista produktów`. 
2. Composer: `Układ -> Stopka` w komponencie `Lista zakupowa - Javascript + CSS + XSLT` w zakładce `JavaScript` trzeba umieścić kod z pliku `main.js`.
3. Composer: `Układ -> Stopka` w komponencie `Lista zakupowa - Javascript + CSS + XSLT` w zakładce `Less/CSS` trzeba umieścić kod z pliku `style.less`.
4. Dla zachowania efektu, który jest podany w przykładzie wyżej. Kod XSLT trzeba umieścić przed elementem prezentującym ikone produktu `<a class="product__icon" />`.

### Parametry, które przyjmuje na wejściu w.w funkcjonalność

```js
  {
    parentSelector: '#search',
    favoriteSelector: '.product__favorite',
    favoriteLinkSelector: '.product__favorite_link',
    sizes: {
      wrapperSelector: '.product__favorite_sizes.--wrapper',
      itemLinkSelector: '.product__favorite_sizes.--item',
      appendToSelector: '.product__icon',
    },
  }
```

## Wyłowanie

### Search

#### Wyłowanie dla searcha:

```js
if(typeof FavoriteProductList === "function") {
  app_shop.fn.SearchFavoriteProductList = new FavoriteProductList();
  app_shop.fn.SearchFavoriteProductList.init();
}
```

Jeżeli nazwy selektorów się róźnią od tych, które są przedstawione w pliku `index.xslt`

```js
if(typeof FavoriteProductList === "function") {
  app_shop.fn.SearchFavoriteProductList = new FavoriteProductList({
    parentSelector: '#search',
    favoriteSelector: '.product__favorite',
    favoriteLinkSelector: '.product__favorite_link',
    sizes: {
      wrapperSelector: '.product__favorite_sizes.--wrapper',
      itemLinkSelector: '.product__favorite_sizes.--item',
      appendToSelector: '.product__icon',
    },
  });
  app_shop.fn.SearchFavoriteProductList.init();
}
```

#### Zwróć uwagę: 

1. Dla prawidłowego działania w.w funkcjonalnosci z filtrami ajax'owymi do app_shop.run jako 4 argument trzeba przekazać `true`, np.
  ```js
    app_shop.run(() => {
      if(typeof FavoriteProductList === "function") {
        app_shop.fn.SearchFavoriteProductList = new FavoriteProductList();
        app_shop.fn.SearchFavoriteProductList.init();
      }
    }, 'all', '#search', true)
  ```

2. Dla prawidłowego działania w.w funkcjonalnosci przy doczytywaniu produktów (InfiniteScroll) w Composer: `Strony -> Lista produktów` 
w komponencie `Lista produktów bez przeładowania strony` w zakładce `Wydzielony JavaScript` należy dodać dodatkowe wyłowanie, np.
  
  ```js
    
    ...

    app_shop.run(function searchAjaxAppShop() {
    
      ...

      updateDomCallback: () => {

        ...

        if(typeof app_shop.fn.SearchFavoriteProductList === "object") {
          app_shop.fn.SearchFavoriteProductList.init();
        }
      
        ...

      }

      ...

    })

    ...

  ```

  oraz 

  ```js
    app_shop.run(function InfiniteScrollAppShop() {
      app_shop.fn.infiniteScroll = new InfiniteScroll({
        updateDomCallback: () => {
          
          ...

          if(typeof app_shop.fn.SearchFavoriteProductList === "object") {
            app_shop.fn.SearchFavoriteProductList.init();
          }

          ...

        }

        ...

      })

      ...

    }, 'all', '.search_page #paging_setting_bottom .pagination')
  ```

### Hotspoty

#### Wyłowanie dla hotspotów:

```js
if(typeof FavoriteProductList === "function") {
  app_shop.fn.HotspotFavoriteProductList = new FavoriteProductList()
  app_shop.fn.HotspotFavoriteProductList.init();
}
```

Jeżeli nazwy selektorów się róźnią od tych, które są przedstawione w pliku `index.xslt`

```js
if(typeof FavoriteProductList === "function") {
  app_shop.fn.HotspotFavoriteProductList = new FavoriteProductList({
    parentSelector: '.hotspot',
    favoriteSelector: '.product__favorite',
    favoriteLinkSelector: '.product__favorite_link',
    sizes: {
      wrapperSelector: '.product__favorite_sizes.--wrapper',
      itemLinkSelector: '.product__favorite_sizes.--item',
      appendToSelector: '.product__icon',
    },
  });
  app_shop.fn.HotspotFavoriteProductList.init();
}
```

#### Zwróć uwagę:

1. Composer: `Układ -> Top` w komponencie `Javascript + CSS + TXT` w zakładce `JavaScript` trzeba umieścić kod wyłowania.
2. Dla prawidłowego działania kod powinien się znajdować w `afterAllHotspotsCallback` 

```js

...

app_shop.fn.hotspotAjaxInit = new HotspotAjaxInit({
      afterAllHotspotsCallback: () => {

        ...

        if(typeof FavoriteProductList === "function") {
          app_shop.fn.HotspotFavoriteProductList = new FavoriteProductList()
          app_shop.fn.HotspotFavoriteProductList.init();
        }

        ...

      }
})

...

```
