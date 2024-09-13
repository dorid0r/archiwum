![image](https://github.com/stipula/case-study/assets/113019879/9b8cb637-e61c-4df6-b1e3-0d8b455c3660)

# Hotspot z czasową ofertą specjalną
* Opis funkcjonalności - Hotspot wyświetla produkt z kampanii promocyjnej z obsługą licznika czasu 'do końca promocji' i statusem ilości produktów pozostałych w promocji.
* Narzędzie - Composer
* Nazwa sklepu - https://amso.pl/

## Komponenty do edycji
- hotspot menu zone1 - z układu (do wyłączenia/ukrycia)
- dowolny komponent do którego chcemy przenieść hotspot
- Javascript + CSS + TXT STANDARD
  
## Jak używać

Zawartość plików [script.js], [script.less] i [script.xml] przenosimy do komponentu, który będzie służył za wrapper dla hotspota.

W komponencie Javascript + CSS + TXT wklejamy kod wywołujący hotspot do callback'a: afterAllHotspotsCallback

Obsługa dodawania do koszyka nie jest tutaj dodana, można wykorzystać funkcję dostępną na Stipula.
Obsługuje omnibusa z końca roku 2023, przed wdrożeniem warto porównać z najnowszą wersją Omnibusa i wprowadzić poprawki.

### konfiguracja w panelu

Konfiguracja hotspota:
Zarządzanie zachowaniem sklepu -> Strefy rekomendacji -> Niezależne strefy rekomendacji -> Strefa 1, W strefie wyświetlaj: Specjalne

Konfiguracja promocji:
Dodajemy promocję ograniczoną czasowo.
Towary promocyjne pokazuj w strefie: Produkt specjalny.

Konfiguracja Produktu

Potrzebne są dwa parametry, id tych parametrów będzie trzeba podmienić w xslt komponentu.
Parametry wyróżniony / ukryty:
- parametr z informacją czy produkt jest oferta dnia
- parametr, który jako wartość przyjmuję wejściową ilość produktu na stanie
