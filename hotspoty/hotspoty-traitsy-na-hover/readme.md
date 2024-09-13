# Traitsy dla hotspotów GraphQl

https://github.com/user-attachments/assets/c21d2a47-9ecb-40aa-bf24-13bb2ec3c049

## Jak prawidłowo zaimplementować w.w funkcjonalność

1. Composer: Układ > Stopka strony > "Hotspoty javascript css"
2. Na poczatku należy otworzyć do edycji komponent wrapper "Hotspoty javascript css". 
3. Następnie edytować komponent "Hotspoty javascript". \
  a) W komponencie tym, należy dodać metodę **setTraits()** z pliku **index.js** do klasy **GetHotspots**. \
  b) w query **HOTSPOTS_GQL** wewnątrz ```products``` należy dodać dodatkowe węzły do zapytania: 
  ```js
  awardedParameters {
    id
    name
    values {
      id
      name
      link      
    }
  }
  ```
4. Metode należy wywołać w metodzie **getHotspotProducts()** po metodzie ```setPrice()```

```js
  getHotspotProducts(hotspotData, hotspotElement) {
    const productsData = hotspotData?.products;
    const hotspotProducts = [];
    productsData?.forEach((el) => {
      const productElement = hotspotElement.querySelector('template.hotspot_product')?.content.cloneNode(true);
      if (!productsData || !productElement) return;
      this.currProductsData = el;
      this.activeTemplate = productElement;

      const { id, name, link } = this.currProductsData;
      const linkAttributes = [{ name: 'href', val: link }, { name: 'title', val: name }];
      this.setHtml('.product', false, [{ name: 'data-id', val: id }]);
      this.setHtml('.product__name', name, linkAttributes);
      this.setHtml('.product__icon', this.getImgElement(), linkAttributes, 'afterbegin');
      this.setPrices();
      this.setTraits();
      hotspotProducts.push(productElement);
    });
    return hotspotProducts;
  }
```

5. Style z pliku style.less najlepiej wrzucić w komponenet "Stronicowanie, Oceny, Blog, Aktualności STANDARD" do ```.product``` lub do ```.hotspot .product``` jeśli nie będziemy używać ich na searchu, style na searchu i tak trzeba dopasować z racji na różnice w std.
6. Dla searcha w index.xml jest kod jaki trzeba podmienieć dla sekcji Parametry (uwzględnienie forbidenIds i usunięcie klas d-none/d-md-block względem std) - należy pamiętać by zmienić $param_search na ""

