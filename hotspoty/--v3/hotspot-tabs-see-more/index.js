// funkcja resetująca standardowe hotspoty 
app_shop.fn.resetHotspots = () => {
  app_shop.fn.hotspotSlick && app_shop.fn.hotspotSlick.destroy();
  app_shop.vars.hotspot_slider && app_shop.vars.hotspot_slider.destroy();

  app_shop.vars.bLazy.revalidate();
  
  app_shop.vars.hotspot_slider && app_shop.vars.hotspot_slider.init();
  if(app_shop.vars.view != 1){
  app_shop.fn.hotspotSlick && app_shop.fn.hotspotSlick.init();
  }
};

app_shop.fn.HotspotTabs = (selectors) => {
    let i = 0; // licznik potrzebny do sprawdzenia czy hotspot na peirwszej zakładce ma link 'zobacz więcej' 
    let firstElement = null;
    let previousElement = null;
    let isMoreButtonCreated = false;

    // tworzymy wrapper na zakładki + zobacz wszystkie
    const tabsWrapper = document.createElement('div');
    tabsWrapper.classList.add('hotspot_tabs');
    // tworzymy wrapper na same zakładki
    const tabsContainer = document.createElement('div');
    tabsContainer.classList.add('hotspot_tabs__tabs');
    
    // utworzenie guzika 'zobacz wszystkie'
    const createMoreButton = (link, isVisible = false) => {
      const moreButton = document.createElement('a');
      moreButton.classList.add('hotspot_tabs__more', 'headline__after');
      if (isVisible) moreButton.classList.add('d-block');
      moreButton.setAttribute('href', link);
      moreButton.setAttribute('title', <iai:variable vid="Kliknij aby zobaczyć wszystkie produkty"/>);
      moreButton.textContent = <iai:variable vid="Zobacz wszystkie"/>;
      tabsWrapper.appendChild(moreButton);
      isMoreButtonCreated = true;
    };
    
    selectors.forEach((selector, index) => {
        const element = document.querySelector(selector);
        if (!element) {
            i++;
            return;
        }
        // jeśli istnieje już pierwsza zakładka, to przenosimy element w DOMie pod hotspot poprzedzający go na liście
        if(previousElement) {
          previousElement.parentNode.insertBefore(element, previousElement.nextSibling);
          previousElement = element;
        }
        if(!firstElement) {
          firstElement = element;
          previousElement = element;
        }
        const tab = element.querySelector('.headline');
        const tab_wrapper = element.querySelector('h2');
        const more = tab.querySelector('.headline__after');
        // jeśli hotspot ma link 'zobacz więcej' i jeszcze nie utworzyliśmy go w zakładkach to go tworzymy
        if(more && !isMoreButtonCreated) { 
          if (index === i) { //jeśli tworzymy dla hotspotu na pierwszej zakładce
            createMoreButton(tab.getAttribute('href'), true);  
          }else { //jeśli tworzymy dla hostpotu, który jest na dalszej zakładce
            createMoreButton(tab.getAttribute('href'));  
          }
        }
        
        // ustawiamy pierwszą zakładkę jako widoczną i przenosimy nagłówek do zakładek
        tab.setAttribute('data-id', selector);
        if (index === i) {
            tab.classList.add('active');
            element.style.display = 'block';
        } else {
            element.style.display = 'none';
        }
        tabsContainer.appendChild(tab_wrapper);        
      
        // dodajemy do utworzonej zakładki event na click
        tab.addEventListener('click', (e) => {
            e.preventDefault();
            if (tab.classList.contains('active')) return;
            
            const prevActive = tab_wrapper.parentElement.querySelector('.active');
            prevActive.classList.toggle('active');
            document.querySelector(prevActive.getAttribute('data-id')).style.display = 'none';
            tab.classList.toggle('active');
            document.querySelector(tab.getAttribute('data-id')).style.display = 'block';
            
            const moreButton  = document.querySelector('.hotspot_tabs__more');
            const link = tab.getAttribute('href');
            if(link && moreButton) {
              moreButton.classList.add('d-block');
              moreButton.setAttribute('href', link);
            }else if(moreButton ) {
              moreButton.classList.remove('d-block');
            }
            // po zmianie zakładki musi być reset hs i odpalenie revalidate jeśli używamy b-lazy dla obrazów
            app_shop.fn.resetHotspots();
            app_shop.vars.bLazy.revalidate();
        });
        
    });
    // dodajemy zakładki do głównego wrapera
    tabsWrapper.prepend(tabsContainer);
    // jeśli istnieje jakikolwiek z podanych hostpotów to dodajemy cały wraper przed pierwszym hotspotem z listy
    if (i < selectors.length) {
       firstElement.parentNode.insertBefore(tabsWrapper, firstElement);
    }
};