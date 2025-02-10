Problem:

+ Przy resize strony 1,2,3,4. Stopka skacze jak szalona :D
+ nie zapisuje się poprawnie, która zakładka jest otwarta a która nie 
+ w głupim przypadku można coś zamknać/otworzyć na mobile a po resizie na desktop będzie miało aria-hidden i będzie pominięte przez czytnik


Problem dokładniej opisany w esklacji:
https://www.iai-system.com/panel/tickets.php?action=ins&ticketId=1239295527

Możliwe że porpawią to sprawnie ale póki co w każdym szablonie to moim zdaniem do zmiany jest :D


Rozwiązanie:

1) Edytujemy komponenet "Moje zamówienie + Regulaminy + Moje konto + Navigation4"
2) podmieniamy funkcje w zwykłym JS - w pliku footer-fix.js są opisane które 2 funkcje należy zmienić na 3 nowe.
3) w stylach css należy podmienić style z pliku footer-fix.less dla:
   1) .footer_tab 
   2) .footer_links_sub

W skrócie:
+ W js zapamiętujemy od razu po wejściu na stronę (funkcja 'all'), które z zakłądek są otwarte a które nie.
+ Dla mobile podstawiamy aria-hdden zgodne z pierwotnym stanem - jeśli zakładka jest zamknięta to aria-hidden = true.
+ Dla pozostałych szerokości aria-hidden zawsze jest falsem bo wszystkie elementy są widoczne i czytniki powinny to czytać.
+ obsługę zakmnięte/otwarte i animacje przenieśliśmy z atrybutu aria-hidden do aria-expanded (aria-hidden jest zmieniany js'em aria-expanded nie więć nie ma przeskoku po przejściu skryptu)
+ dodatkowo na rozwinięcie/zwinięcie zakłądki dodajemy klasę 'height-transition' która obsługuje nam animacje. Klasa jest usuwana na resize strony. Dzięki czemu nie ma przy reszie dziwnego skakania strony i zmieniania z transition max-heightów.
