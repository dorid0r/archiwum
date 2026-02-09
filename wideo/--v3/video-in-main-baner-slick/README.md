# Obsługa video w głównym banerze

Skrypt do kontrolowania plików video w banerze 1 na stronie głównej dodanych jako kod HTML. Kontroluje wczytywanie, włączanie i pauzowanie video.

## Jak używać

Funkcję ***VideoInSlider*** należy dodać do głównego banera.

Wywołanie funkcji

```js
app_shop.run(function banery() {
  app_shop.fn.sliderVideo = new VideoInSlider();
  app_shop.fn.sliderVideo.init();
}, 'all', '#main_banner1');
```
### Slick

Popdpięcie pod główny slider. Trzeba dodać odpowienide wywołania do funkcji ***app_shop.fn.mainSlider*** aby video sie włączało i pauzowało.

```js
app_shop.fn.mainSlider = new MainSlider({
  selector: '.main_slider:not(.slick-initialized)',
  callbackAfter: () => {
    app_shop.fn.sliderVideo.playVideo();
  },
  callbackBefore: (slider) => {
    slider.on('afterChange', () => {
      if (document.querySelector('#main_banner1 .slick-active img:not(.b-loaded)')) app_shop.vars.bLazy.revalidate();
      // ODPALENIE VIDEO
      app_shop.fn.sliderVideo.playVideo();
    });
    slider.on('beforeChange', () => {
      // PAUZOWANIE VIDEO
      app_shop.fn.sliderVideo.pauseVideo();
    });
  },
});

```
### CSS
Dla banera warto dodać style, które ukryją domyslne kontrolki dla video.

```css
#main_banner1 video::-webkit-media-controls {
  display: none;
}
```

Wykorzystaj różne jakości/rozmiary plików video dla róznych rozdzielczości ekranu.

Aby działanie było optymalne wymagane są 2 dodatkowe parametry dal tagu *video* :
- **preload** - z ustawioną wartością **none**
- **poster** - z odnosnikiem do zdjęcia pierwszą klatką filmu (lub dowolnego innego, które ma się wyświetlać do momentu włączenia odtwarzania)


## Struktura html

Przykład z zoptymalziwoanym video

```html
<video poster="https://shop36340-1.iai-shop.com/data/include/cms/banery/baner_desktop.webp?v=1708439464827" preload="none">
  <source src="https://shop36340-1.iai-shop.com/data/include/cms/bannery/video_desktop.mp4?v=1708438140688" type="video/mp4" media="(min-width: 979px)">
  <source src="https://shop36340-1.iai-shop.com/data/include/cms/bannery/video_mobile.mp4?v=1708438140688" type="video/mp4">
</video>
```
