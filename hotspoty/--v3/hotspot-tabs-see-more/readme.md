# Funkcja tworząca zakładki dla podanych stref rekomendacji.

![2024-07-12 11_03_55-Części i akcesoria do przyczep samochodowych UNITRAILER](https://github.com/user-attachments/assets/9ef5a80e-2ffe-43e5-af27-f2c5cb0e9394)

## Działanie funkcji
+ Tworzy zakładki dla podanych hotspotów, wkleja je przed pierwszy istniejący na liście hotspot. 
+ Ustawia hostpoty w DOMie w odpowiedniej kolejności. 
+ Dodatkowo obsługuje guzik 'zoabcz więcej' dla hostpotów, które go zwracają.

## instrukcja:

+ wkleić kod z index.js do szablonu - najlepiej do Javascript + CSS + TXT tam gdzie mamy kod dla Hotspotów.
+ wkleić kod z style.less do szablonu
+ wywołać funkcję w callbacku 'afterAllHotspotsCallback'

## Wywołanie funkcji
Wywołanie funkcji dodajemy w callbacku 'afterAllHotspotsCallback' np.

```js
const mainSelector = document.querySelector('.main_page');
if(mainSelector){
  app_shop.fn.HotspotTabs(['#ten_hs_nieistnieje', '#main_hotspot_zone1', '#main_hotspot_zone2']); 
  app_shop.fn.HotspotTabs(['#products_zone1', '#products_zone2']);
  app_shop.fn.HotspotTabs(['#main_hotspot_zone3', '#main_hotspot_zone4']);
}
```

W tym przypadku na mainie odpalą się 3 niezależne zestawy hostpotów w zakładkach:

![2024-07-12 11_59_17-Części i akcesoria do przyczep samochodowych UNITRAILER](https://github.com/user-attachments/assets/23058197-515d-4731-8168-e0ebb50740f9)

## Przykład użycia
https://unitrailer-test.iai-shop.com/ - trzeba wejść z composera - strona techniczna na start.
