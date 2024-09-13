# Labele dla hotspotów GraphQl

![Screenshot_1](https://github.com/user-attachments/assets/0e9d5967-ee95-4c7f-b467-3db854d3025b)

## Jak prawidłowo zaimplementować w.w funkcjonalność

1. Composer: Układ > Stopka strony > "Hotspoty javascript css"
2. Na poczatku należy otworzyć do edycji komponent wrapper "Hotspoty javascript css". 
3. Następnie edytować komponent "Hotspoty javascript". W komponencie tym, należy dodać kod z pliku labels.js do klasy GetHotspots.



## Wywołanie
Metode należy wywołać w metodzie getHotspotProducts(). 

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
      this.setLabels();
      hotspotProducts.push(productElement);
    });
    return hotspotProducts;
  }
```

## Zwróć uwagę
1. Ważne aby wywołać ją po metodzie setPrices().
2. Możliwe, że po utworzniue nowego komponentu, trzeba będzie go jeszcze wymienić, ponieważ może zostać domyślny komponent w szablonie
3. Kolejność etykiet w tablicy labelConfig, jest istotna, aby etykiety pokrywały się ze standardowymi etykietami zwracanymi z XML 
