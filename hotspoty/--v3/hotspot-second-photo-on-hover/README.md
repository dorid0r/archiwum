# Drugie zdjęcie na hover
Funkcja podmieniająca zdjęcie na 2 przy hoverze
![Screenshot_7](https://github.com/stipula/case-study/assets/131850653/e205aae8-f096-4605-b50f-766384057788)
![Screenshot_8](https://github.com/stipula/case-study/assets/131850653/35f99be8-02d9-4d29-ab52-6294046bc96e)


## Jak używać
Dla poprawnego działania w XML hotspotach wymagane są 3 atrybuty:

**product_id** - id dla produktu

**data-first_src** - dla ikony produktu gdzie podana jest ścieżka do ikony produktu

**data-second_src** - dla ikony produktu gdzie podana jest ścieżka do drugiego zdjęcia produktu

```xml
<div class="product">
  <iaixsl:attribute name="data-product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
	<!--...-->
  <a class="product__icon">
    <iaixsl:if test="count(enclosures/images/enclosure) > 1">
      <iaixsl:attribute name="data-first_src"><iaixsl:value-of disable-output-escaping="yes" select="$var_icon"/></iaixsl:attribute>
      <iaixsl:attribute name="data-second_src"><iaixsl:value-of select="enclosures/images/enclosure[2]/@medium"/></iaixsl:attribute>
    </iaixsl:if>
    <!--...-->
  </a>
</div>
```

Odpalanie JS w app_shop.fn.hotspotAjaxInit w metodzie afterAllHotspotsCallback

```JS
const hotspotSecondPhoto = new SecondPhotoHover(document.querySelectorAll('.hotspot'));
hotspotSecondPhoto.init();
```