# Prosty slider bazujący na właściwości CSS scroll-snap
![Screenshot at Oct 04 14-45-14](https://github.com/stipula/case-study/assets/99257908/79dbf06b-4080-49d6-b3ed-774e1e0b7039)

## Jak używać:
1. Dodać strukturę HTML w XSLT z pliku "index.xsl" (linie 132-234) 
2. Dodać funkcję "ScrollSnapSlider" z pliku "index.js"
3. Dodać style CSS z pliku "style.less"
4. Dodać do szablonu zmienną @scroll_snap_gap: 1.5rem;
5. Wywołać funkcję:
```js
  app_shop.run(function(){
    
    const searchProductsIconList = document.querySelectorAll('.product__icon__list');
    app_shop.fn.scrollSnapSliderSearchProductsIcon = new ScrollSnapSlider(searchProductsIconList, '.product__icon__list__item');
    app_shop.fn.scrollSnapSliderSearchProductsIcon.init();

  }, 'all', '#search', true);
```
