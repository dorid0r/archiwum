// Klasa SearchCategories, obsługująca logikę wyszukiwania kategorii
class SearchCategories {
  
    // Inicjalizuje elementy i nasłuchiwanie zdarzeń
    init() {
      // Pobiera element tytułu kategorii wyszukiwania
      this.searchCategoriesTitle = document.querySelector('.search-categories-title');
      
      // Pobiera element listy kategorii wyszukiwania
      this.filterContent = document.querySelector('.search-categories-list');
      
      // Pobiera wszystkie elementy listy kategorii (linki)
      this.searchTopCatListItems = document.querySelectorAll('a.search_top_cat_list_item');
      
      // Dołącza nasłuchiwanie zdarzeń do elementów
      this.attachEventListeners();
    }
  
    // Dołącza nasłuchiwanie zdarzeń do elementów
    attachEventListeners() {
      // Dodaje nasłuchiwanie zdarzeń dla kliknięcia na tytuł kategorii
      this.searchCategoriesTitle.addEventListener('click', this.handleTitleClick.bind(this));
      
      // Dodaje nasłuchiwanie zdarzeń dla kliknięcia na każdy element listy kategorii
      this.searchTopCatListItems.forEach((item) => {
        item.addEventListener('click', this.handleListItemClick.bind(this, item));
      });
    }
  
    // Obsługuje zdarzenie kliknięcia na tytuł kategorii
    handleTitleClick(event) {
      // Znajduje element listy kategorii powiązany z klikniętym tytułem
      const slidetoggle = this.searchCategoriesTitle.parentNode.querySelector('.search-categories-list');
      
      // Przełącza widoczność listy kategorii
      this.slideToggle(slidetoggle);
      
      // Ukrywa inne treści poza obecnie klikniętą listą
      this.hideOtherContent(slidetoggle);
      
      // Przełącza klasę CSS '--open' na tytule kategorii
      this.searchCategoriesTitle.classList.toggle('--open');
      
      // Zatrzymuje dalsze propagowanie zdarzenia kliknięcia
      event.stopPropagation();
    }
  
    // Obsługuje zdarzenie kliknięcia na element listy kategorii
    handleListItemClick(item) {
      // Resetuje aktywne elementy listy
      this.resetActiveItems();
      
      // Dodaje klasę 'active' do klikniętego elementu
      item.classList.add('active');
      
      // Usuwa atrybut 'selected' ze wszystkich opcji select
      document.querySelectorAll('select.category_node option').forEach((option) => {
        option.removeAttribute('selected');
      });
  
      // Pobiera ID klikniętego elementu
      const id = item.getAttribute('id');
      
      if (id) {
        // Jeśli ID istnieje, ustawia odpowiednią opcję select jako wybraną
        const selectedOption = document.querySelector(`select.category_node option[value="${id}"]`);
        selectedOption.setAttribute('selected', 'selected');
      } else {
        // Jeśli ID nie istnieje, ustawia pierwszą opcję select jako wybraną
        const defaultOption = document.querySelector('select.category_node option:first-child');
        defaultOption.setAttribute('selected', 'selected');
      }
  
      // Ukrywa pierwszy element listy, jeśli jego treść jest równa treści klikniętego elementu
      if (item.innerHTML === document.querySelector('a.search_top_cat_list_item.first').innerHTML) {
        document.querySelector('a.search_top_cat_list_item.first').style.display = 'none';
      } else {
        document.querySelector('a.search_top_cat_list_item.first').style.display = 'block';
      }
  
      // Ustawia tytuł kategorii jako tekst klikniętego elementu
      document.querySelector('div.search-categories-title').innerHTML = item.innerHTML;
      
      // Ukrywa elementy listy kategorii oraz elementy auto-uzupełniania
      document.querySelectorAll('div.search-categories-list,.ui-autocomplete').forEach((element) => {
        element.style.display = 'none';
      });
      
      // Przełącza klasę CSS '--open' na tytule kategorii
      this.searchCategoriesTitle.classList.toggle('--open');
    }
  
    // Przełącza widoczność elementu
    slideToggle(element) {
      // Sprawdza, czy element jest ukryty
      const isHidden = window.getComputedStyle(element).display === 'none';
      
      // Jeśli element jest ukryty, pokazuje go; w przeciwnym razie ukrywa
      if (isHidden) {
        element.style.display = 'block';
      } else {
        element.style.display = 'none';
      }
    }
  
    // Ukrywa wszystkie inne treści poza obecnie przekazanym elementem
    hideOtherContent(element) {
      // Pobiera wszystkie elementy listy kategorii
      const filterContent = document.querySelectorAll('.search-categories-list');
      
      // Przechodzi przez wszystkie elementy i ukrywa je, jeśli są widoczne i nie są elementem przekazanym
      filterContent.forEach((content) => {
        if (content !== element && window.getComputedStyle(content).display === 'block') {
          content.style.display = 'none';
        }
      });
    }
  
    // Resetuje aktywne elementy listy
    resetActiveItems() {
      // Usuwa klasę 'active' ze wszystkich elementów listy kategorii
      document.querySelectorAll('a.search_top_cat_list_item').forEach((item) => {
        item.classList.remove('active');
      });
    }
  }
  
  // Inicjalizacja instancji SearchCategories
  app_shop.fn.searchCategories = new SearchCategories({
  
  });
  
  app_shop.run(function () {
    // Pobiera wszystkie elementy listy kategorii
    const searchTopCatListItems = document.querySelectorAll('a.search_top_cat_list_item');
    
    // Pobiera wszystkie opcje z selectu
    const categoryNodeOptions = document.querySelectorAll('select.category_node option');
    
    // Pobiera tytuł kategorii wyszukiwania
    const searchCategoriesTitle = document.querySelector('div.search-categories-title > *');
    
    // Pobiera pierwszy element listy kategorii
    const firstSearchTopCatItem = document.querySelector('a.search_top_cat_list_item.first');
  
    // Usuwa klasę 'active' ze wszystkich elementów listy kategorii
    searchTopCatListItems.forEach(function (item) {
      item.classList.remove('active');
    });
  
    // Usuwa atrybut 'selected' ze wszystkich opcji select
    categoryNodeOptions.forEach(function (option) {
      option.removeAttribute('selected');
    });
  
    // Ustawia tytuł kategorii jako tekst pierwszego elementu listy
    searchCategoriesTitle.innerHTML = firstSearchTopCatItem.innerHTML;
  
    // Ustawia pierwszą opcję select jako wybraną
    const firstOption = document.querySelector('select.category_node option:first-child');
    firstOption.setAttribute('selected', 'selected');
  }, [1, 2], '#menu_search');
  
  app_shop.run(function () {
    // Inicjalizuje instancję SearchCategories
    app_shop.fn.searchCategories.init();
  }, 'all', '#menu_search');
  