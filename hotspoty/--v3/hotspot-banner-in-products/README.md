# Hotspoty z banerem
Funkcja budująca hotspoty z banerem na pierwszym miejscu kafelka produktowego.
![Screenshot_2](https://github.com/stipula/case-study/assets/131850653/916d638c-b188-4b4f-b0e9-19adf9ac21a0)

W przykładzie  grafika banerowa pobierana jest z menu 3 ale można dostosować i pobierać np grafikę ze stref reklamowych.

## Jak używać
W kodzie dodajemy znaczniku **template** z data-id równym id strefy do której przynależy. Wewnątrz deklarując strukturę kafelka dla banera.

```XSLT
<iaixsl:if test="/shop/navigation3/item[2][@name and @gfx_inactive_desktop and @gfx_inactive_mobile and @gfx_inactive_tablet]">
  <template data-id="main_hotspot_zone2">
    <div class="product --banner">
    <!--...-->
    </div>
  </template>
</iaixsl:if>
```

W JS potrzebujemy funkcj do przebudowania stref hotspot **addBannerToHotspots**, która przyjmuje jeden argument:

- **selector** - wymagany, selektor dla kafelka z banerem

```js
function addBannerToHotspots(selector) {
  document.querySelectorAll('.hotspot').forEach((hotspot) => {
    const template = document.querySelector(`template[data-id="${hotspot.id}"]`);
    const banner = template?.content?.querySelector(selector);
    if (!template || !banner) return;
    hotspot.querySelector('.products').prepend(banner);
    hotspot.querySelector('.products').scrollLeft = 0;
  });
}

//wywołanie w afterAllHotspotsCallback
addBannerToHotspots('.--banner');
```
