# Dynamicznie sekcje v2 pobierające produkty z navigation na podstawie ID
## Jak używać:
1. Stwórz tablice obiektów o nazwie "categoryData" w komponencie z układu. Obiekt powinien zawierać: id, nazwę i link do kategorii. W pliku "menu.xsl" znajduje się gotowy kod XSLT dla menu 2.
```js
[
  {
    "id": 790,
    "name": "Classics",
    "url": "/pl/menu/classics-790"
  },
  {
    "id": 788,
    "name": "Diemme",
    "url": "/pl/menu/diemme-788"
  }
]
```
2. Przygotuj strukturę HTML do pobierania z listy towarów. Zwykle wystarczy powielić zawartość komponentu SEARCH i otoczyć znacznikiem IAI AJAX.
```xml
<iaiajaxstart iai-ajax-id="dynamic_section" iai-ajax-generated="false"/>...<iaiajaxend/>
```
Należy pamiętac o zmianie nazw zmiennych w powielonej strukturze - wystarczy dopisek "_ajax". Np
```xml
<iaixsl:variable name="param_search"></iaixsl:variable>
```
zamienić na
```xml
<iaixsl:variable name="param_search_ajax"></iaixsl:variable>
```
Po zmianie należy zaktualizować wszystkie odniesienia do zmiennych w obrębie znacznika IAI AJAX.

3. Dwa sposoby dodania sekcji HTML:
   1. Ręcznie w strefach CMS lub strefach reklamowych przez panel
    ```html
    <section class="hotspot__dynamic mb-5" data-id="791,792,793,794">
       <div class="hotspot__dynamic__skeleton">
           <span class="headline"></span>
           <div class="products">
               <div class="product">
                   <span class="product__icon d-flex justify-content-center align-items-center"></span>
                   <div class="product__details">
                       <span class="product__name"></span>
                       <div class="product__prices"></div>
                   </div>
               </div>
               <div class="product">
                   <span class="product__icon d-flex justify-content-center align-items-center"></span>
                   <div class="product__details">
                       <span class="product__name"></span>
                       <div class="product__prices"></div>
                   </div>
               </div>
               <div class="product">
                   <span class="product__icon d-flex justify-content-center align-items-center"></span>
                   <div class="product__details">
                       <span class="product__name"></span>
                       <div class="product__prices"></div>
                   </div>
               </div>
               <div class="product">
                   <span class="product__icon d-flex justify-content-center align-items-center"></span>
                   <div class="product__details">
                       <span class="product__name"></span>
                       <div class="product__prices"></div>
                   </div>
               </div>
           </div>
       </div>
    </section>
    ```
   2. Bezpośrednio w szablonie poprzez pobieranie idków z węzła menu2, aby w przypadku korzystania z jednego szablonu na kilku sklepach można było tworzyć rożne węzły

    ```xml
    <iaixsl:variable name="ids"><iaixsl:for-each select="/shop/navigation2/item/@id"><iaixsl:value-of select="."/><iaixsl:if test="position() != last()">,</iaixsl:if></iaixsl:for-each></iaixsl:variable>
    <section class="hotspot__dynamic">
      <iaixsl:attribute name="data-id"><xsl:value-of select="$ids"/></iaixsl:attribute>
    ```

4. Dodaj funkcję DynamicSections oraz AddToFavorite (index.js) do szablonu
5. Dodaj style css (style.less) do szablonu
6. Wywołaj funkcję:
```js
const hotspots = document.querySelectorAll(".hotspot__dynamic");
app_shop.vars.dynamicSectionsSettings = {
  cssClass: {
    tab: "hotspot__dynamic__tab hotspot__dynamic__tab__custom"
  }
}
app_shop.fn.dynamicSections = new DynamicSections(app_shop.vars.dynamicSectionsSettings,  null);
hotspots.forEach((hotspot) => app_shop.fn.dynamicSections.inView(hotspot));
```
## Fix dla hotspotu, który ma dodatkowy content (np. warianty na hover lub dodanie do koszyka)
W takim przypadku należy liczyć wysokość dla każdej zakładki osobno, poniżej przykład rozwiązania tego problemu:
```js
if (!this.settings.config.slider && app_shop.vars.bLazy.revalidate)
  app_shop.vars.bLazy.revalidate();
  $('.hotspot__dynamic .product').maxHeight();
```
