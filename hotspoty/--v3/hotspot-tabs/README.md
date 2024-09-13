# Funkcja tworząca zakładki dla istniejących stref rekomendacji.
Wygląd na desktop

![image](https://github.com/stipula/case-study/assets/110026991/f1058c95-02d2-4c5d-993a-ac8698c1d8e1)

Wygląd na mobile (zakładki zwijane) - jeżeli ktoś nie chce stosować innego rozwiązania na mobile, wystarczy usunąć osobną funkcję dla mobilnych tabsów i wywołać jedynie desktopowe (możliwe, że będzie trzeba to inaczej ostylować).

![image](https://github.com/stipula/case-study/assets/110026991/2b243aa1-442e-40da-b2a8-78f30946f58e)

## Działanie funkcji
Funkcja zbiera wszystkie wygenerowane hotspoty i otacza je zakładkami, jeżeli hotspoty mają odpalonego slicka poprzez --slider, to w zakładkach również będzie działać. Możliwe korzystanie zarówno w wersji slick oraz bez. Nie trzeba nic zmieniać w funkcji jeżeli ma działać identycznie jak na przykładzie, wystarczy przy wywołaniu podać selektor, czy chcemy użyć funkcji na mainie, czy na projectorze.

## Wywołanie funkcji
Wywołanie funkcji dodajemy w callbacku 'afterAllHotspotsCallback' z odpowiednim selectorem, np.
```js
const mainSelector = document.querySelector('.main_page');
if(mainSelector && app_shop.fn.initTabsHotspot && app_shop.vars.view > 2) {
  app_shop.fn.initTabsHotspot('.main_page .hotspot');
}

if(mainSelector && app_shop.fn.tabsMobileHS) {
  app_shop.fn.tabsMobileHS('.main_page .hotspot h2');
}
```

## Przykład użycia
Funkcja wykorzystana jest na sklepie porcja.eu na stronie głównej (obecnie nie ma domeny, więc jest to domena techniczna) - https://shop22002-1.yourtechnicaldomain.com
