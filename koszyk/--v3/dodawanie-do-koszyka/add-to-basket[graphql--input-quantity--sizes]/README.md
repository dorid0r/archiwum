this.options.autoClose = false
![image](https://github.com/stipula/case-study/assets/99257908/85f9a175-d179-4517-8ef6-26d43a2e423d)

![image](https://github.com/stipula/case-study/assets/99257908/50b8d38e-34b8-4c5e-8289-0271e9eeee4a)

this.options.autoClose = true
![image](https://github.com/stipula/case-study/assets/99257908/b3557ec8-ea04-414a-8dbe-31cab9e47560)

![image](https://github.com/stipula/case-study/assets/99257908/c7380916-e64e-4cce-9835-617aae7ed7f6)


1. Dodać kod XSLT z pliku index.xsl do pętli w hotspotach czy na liście towaru
2. Dodać style LESS do komponentu styli
3. Dodać funkcje ProductBuy do komponentu w układzie. Najlepiej w "Javascript + CSS + TXT"
4. Wywołć funkcję

W przypadku użycia slicka w hotspocie lista rozmiarów może nie wyświetlać się w całości (kontener slicka ma overflow:hidden). Gotowe rozwiązanie jest w CSS Tricks:
[Hotspot (slider) i dodawanie do koszyka na hover](https://github.com/stipula/case-study/tree/main/css-tricks)

Przykładowe wywołanie dla hotspotów w callbacku "afterAllHotspotsCallback":

~~~js
app_shop.fn.productBuyHotspots = new ProductBuy('.hotspot');
app_shop.fn.productBuyHotspots.init();
~~~
