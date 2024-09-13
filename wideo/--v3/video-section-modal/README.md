# Strefa z video YT otwieranymi w modalu

Strefa oparta jest o funkcjonalność filmów z Youtube z placeholderem, zabezpieczając przed utratą punktów w pagespeed. Filmy otwierane są w systemowym modalu. Dodatkowo można dodawać podpisy do filmów i właczyć/wyłaczyć slick na danym widoku.

![Screenshot_1](https://github.com/stipula/case-study/assets/131850653/c769d601-eaf4-4364-9efb-a01f79e3cefa)


![Screenshot_5](https://github.com/stipula/case-study/assets/131850653/c9f030ee-6bcc-4d07-a4f6-5b1d8d91749e)

## Jak używać
Strefę można wdrozyć na kazdej strefie reklamowej (baner lub button).
### Dodawanie filmu w panelu
Filmy dodawane są w panelu w danej strefie - należy ustawić tryb reklamy HTML i wtreść wkleić id filmiku z YT.

### Ustawienia komponenntu
Popdis to nazwa reklamy pobierana z panelu. Aby nie generować popdisów należy w XML zmienną **show_description** ustawić pustą

```xml
<iaixsl:variable name="show_description"></iaixsl:variable> 
```

W zmiennej **yt_accounyt_account** możemy podać nazwe konta na YT wtedy nagłowek będzie linkiem zewnętrznym

```xml
<iaixsl:variable name="yt_account">kettlersport_pl</iaixsl:variable>
```

W zmiennej **cms_link** możemy podać adres strony do której strefa ma linkowac jesli nie jesto profil na YT

```xml
  <iaixsl:variable name="cms_link"></iaixsl:variable>
```

Jeśli nie podamy **yt_accounyt_account** ani **cms_link** to nagłowek strefy będzie bydowany na pdostawie **yt_headline**

```xml
  <iaixsl:variable name="yt_headline"><iai:variable vid="Strefa video" /></iaixsl:variable> 
```

### Wywołanie funkcji

```js
app_shop.fn.videoYtSection = new VideoYtSection();

app_shop.run(function videoYtSectionInit() {
  app_shop.fn.videoYtSection.init();;
}, 'all', '.video_button .video');
```

### Odpalanie slicka
Funkcja
```js
app_shop.run(function videoYtSectionSlick() {
  app_shop.fn.videoYtSection.slider();
}, [1, 2, 3, 4], '.video_button .video');
```
Domyślnie slick będzie odpalony jeżeli będzie więcej niż 4 filmy i widok laptop lub desktop. Tymi ustawieniami można sterować przez parametry wywołania:

**sliderSelector** - element do podpięcia Slicka

**sliderOptions** - ustawienia slicka

**minimalSlidesToRun** - określa minmalną liczbę itemów aby Slick był odpalany, domyślnie 5

**sliderRuningViews** - tablica z wyróznieniem na jakich widokach odpalać slick, domyslnie [3,4]

Przykład odpalenia z dodatkowymi opcjami dla Slick:
```js
app_shop.fn.videoYtSection = new VideoYtSection({
  sliderOptions: {
    infinite: false,
    slidesToShow: 3,
  }, 
  sliderSelector: '.video_button__list', 
  minimalSlidesToRun: 2,
  sliderRuningViews: [4]
});
app_shop.fn.videoYtSection.init();

app_shop.run(function videoYtSectionSlick() {
  app_shop.fn.videoYtSection.slider();
}, [1, 2, 3, 4], '.video_button .video');
```

## Przykład użycia
Funkcja wykorzystana jest w sklepie Kettler [id 32043] na stronie głównej (obecnie nie ma domeny) - https://shop32043-1.yourtechnicaldomain.com/
