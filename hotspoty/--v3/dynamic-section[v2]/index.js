/**
 * Dynamicznie sekcje pobierające produkty z navigation na podstawie ID
 * @param {object} params obiekt z ustawieniami
 * @param {params} config możliwość wyłaczenia obsługi dodawania do listy zakupowej oraz slidera
 * @param {params} cssClass domyślne klasy dla elementów DOM z możliwością dodania klas w obiekcie params (nie usuwać domyślnych klas). Własne klasy można również dodać w template content
 * @param {params} id szablony template oraz div#content
 * @param {params} section odwołanie do znacznika H tag użytego w template content
 * @param {params} slick ustawienia dla slidera
 * @param {params} txt ustawienia literałów
 * @param {function} callback funkcja uruchamiana po otrzymaniu odpowiedzi z bramek
 * @returns
 */
 function DynamicSections(params, callback) {
  params && typeof params === "object" ? params : (params = {});

  /** Funkcja pomocnicza do dzielenia klas podczas używania metody classList.add() */
  const splitClassHelper = (text = "") => text?.split(" ");

  /** Ustawienia dla klas, literałów i slicka */
  this.settings = {
    config: {
      addToFav: params.config?.addToFav || true,
      slider: params.config?.slider || true,
      sliderMobile: params.config?.sliderMobile || false,
    },
    cssClass: {
      getDialogElement:
        params.cssClass?.getDialogElement || ".sl_dialog.sizes_dialog_search",
      getDialogClose:
        params.cssClass?.getDialogClose || ".sizes_dialog.--close",
      getDialogTop:
        params.cssClass?.getDialogTop || ".sl_choose__item.--top.mb-2",
      getDialogSizes:
        params.cssClass?.getDialogSizes || ".sl_choose__item.--sizes",
      getDialogSizesButton:
        params.cssClass?.getDialogSizesButton || ".product__sizes__button",
      getAddToListButton:
        params.cssClass?.getAddToListButton || ".product__favorite",
      getProduct: params.cssClass?.getProduct || ".product",
      getTabs: params.cssClass?.getTabs || ".hotspot__dynamic__tabs",
      getTab: params.cssClass?.getTab || ".hotspot__dynamic__tab",
      getSections:
        params.cssClass?.getSections || ".hotspot__dynamic__sections",
      getSection: params.cssClass?.getSection || ".hotspot__dynamic__section",
      getSectionRow:
        params.cssClass?.getSectionRow || ".hotspot__dynamic__section__row",
      getSectionMore:
        params.cssClass?.getSectionMore || ".hotspot__dynamic__section__more",
      active: params.cssClass?.getActive || "--active",
      getActive: params.cssClass?.getActive || ".--active",
      loader: params.cssClass?.loader || "load-content",
      getSkeleton:
        params.cssClass?.getSkeleton || ".hotspot__dynamic__skeleton",
      getHeader: params.cssClass?.getHeader || ".headline",
      getHeaderName: params.cssClass?.getHeaderName || ".headline__name",
      getHeaderAfter: params.cssClass?.getHeaderAfter || ".headline__after",
    },
    id: {
      getContent: params.id?.getContent || "#content",
      getSingleTemplate: params.id?.getSingleTemplate || "#single-template",
      getMultiTemplate: params.id?.getMultiTemplate || "#multi-template",
      getDialogSizesTemplate:
        params.id?.getDialogSizesTemplate || "#dialog-sizes",
    },
    section: {
      headerTag: params.section?.headerTag || "h2",
    },
    slick: {
      breakpoint: {
        md: params.slick?.breakpoint?.md || "1054",
      },
      settings: {
        slidesToScroll: params.slick?.settings?.slidesToScroll || 1,
        infinite: params.slick?.settings?.infinite || false,
        prevArrow:
          params.slick?.settings?.prevArrow ||
          "<a class='slick-prev' href=''><i class='icon-angle-left'></i></a>",
        nextArrow:
          params.slick?.settings?.nextArrow ||
          "<a class='slick-next' href=''><i class='icon-angle-right'></i></a>",
      },
    },
    txt: {
      linkMoreAfter:
        params.txt?.linkMoreAfter ||
        app_shop.txt.linkMoreAfter ||
        "Zobacz więcej",
      linksMoreAfter:
        params.txt?.linksMoreAfter ||
        app_shop.txt.linksMoreAfter ||
        "Zobacz wszystkie",
      chooseSize:
        params.txt?.chooseSize ||
        app_shop.txt.txt_74629_8 ||
        "Proszę wybrać rozmiar",
    },
  };

  /** Magazyn danych dla sliderów oraz kodu HTML otrzymanego z bramki AJAX */
  this.storage = {
    sliders: [],
    response: [],
  };

  /**
   * Dodawanie do ulubionych (zewnętrzna klasa AddToFavorite)
   * @param section wrapper sekcji
   */
  this.addToFav = (section) => {
    AddToFavorite ? AddToFavorite(section, this.settings) : false;
  };

  /**
   * Tworzenie slidera (slick-slider)
   * @param {*} wrapper wrapper dla produktów w sekcji
   * @param {*} sliderItemsDesktop ilość elementów widocznych w widoku desktop (domyślnie 4) - przekazywane w atrybucie data-desktop w głównym wrapperze (elem); przyjmuje wartości zmiennoprzecinkowe
   * @param {*} sliderItemsMobile  ilość elementów widocznych w widoku mobile (domyślnie 2) - przekazywane w atrybucie data-desktop w głównym wrapperze (elem); przyjmuje wartości zmiennoprzecinkowe
   */
  this.slider = (wrapper, sliderItemsDesktop, sliderItemsMobile, storageArray) => {
    const slick = $(wrapper).slick({
      ...this.settings.slick.settings,
      slidesToShow: sliderItemsDesktop ? parseFloat(sliderItemsDesktop) : 4,
      responsive: [
        {
          breakpoint: this.settings.slick.breakpoint.md,
          settings: {
            slidesToShow: sliderItemsMobile ? parseFloat(sliderItemsMobile) : 2,
          },
        },
      ],
    });

    slick.on("afterChange", () => {
      if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
    });
    
    storageArray.push(slick);
  };

  /** Pobieranie listy produktów dla konkretnej kategorii */
  this.get = {
    section: async (url, id) => {
      const cacheSection = sessionStorage.getItem(`section_${id}`);
      if (cacheSection !== null) {
        return JSON.parse(cacheSection);
      }

      if (url === "") return null;

      const response = await fetch(
        `${url}?shop_xml=1&get_ajax_items=dynamic_section`
      );

      const responseClone = await response.clone().text();
      if (responseClone.includes("!DOCTYPE html")) return null;

      sessionStorage.setItem(
        `section_${id}`,
        JSON.stringify(await response.clone().json())
      );
      
      return response.json();
    },
    sections: async (categories) => {
      const requests = categories.map(async (category) => {
        const data = this.get.section(category.url, category.id);
        return data;
      });
      return Promise.all(requests);
    },
  };

  /** Szablony dla pojedynczych/mnogich sekcji przygotowane na podstawie tagów template dla odpowiedniego wariantu */
  this.template = {
    single: {
      header: (elem, cloneTemplate) => {
        const sectionsHeader = elem.dataset.header;
        const header = cloneTemplate.querySelector(
          this.settings.section.headerTag
        );

        if (sectionsHeader === "false") {
          header.remove();
          return;
        }

        const headerLink = header.querySelector(
          this.settings.cssClass.getHeader
        );
        const headerName = headerLink.querySelector(
          this.settings.cssClass.getHeaderName
        );
        const headerAfter = headerLink.querySelector(
          this.settings.cssClass.getHeaderAfter
        );

        headerLink.setAttribute(
          "href",
          window.location.origin + this.currentCategory.url
        );

        headerName.textContent = this.currentCategory.name;
        headerAfter.textContent = this.settings.txt.linkMoreAfter;

        elem.appendChild(header);

        return;
      },
      row: (elem, cloneTemplate, data) => {
        const sectionElem = cloneTemplate.querySelector(
          this.settings.cssClass.getSection
        );

        sectionElem.insertAdjacentHTML("afterbegin", data.dynamic_section);

        elem.appendChild(sectionElem);
      },
      complete: (elem, data) => {
        const template = document.querySelector(
          this.settings.id.getSingleTemplate
        );
        const cloneTemplate = template.content.cloneNode(true);

        this.template.single.header(elem, cloneTemplate);
        this.template.single.row(elem, cloneTemplate, data);
      },
    },
    multi: {
      tab: (section, index, cloneTemplate) => {
        if (!section) return null;

        const tabTemplate = cloneTemplate.querySelector(
          this.settings.cssClass.getTab
        );
        const cloneTabTemplate = tabTemplate.cloneNode(true);

        cloneTabTemplate.dataset.index = index.toString();
        index === 0
          ? cloneTabTemplate.classList.add(
              ...splitClassHelper(this.settings.cssClass.active)
            )
          : null;
        cloneTabTemplate.querySelector("span").textContent =
          this.currentCategories[index].name;

        return cloneTabTemplate;
      },
      tabs: (elem, cloneTemplate, data) => {
        const tabs = cloneTemplate.querySelector(
          this.settings.cssClass.getTabs
        );
        const sectionsContainer = cloneTemplate.querySelector(
          this.settings.cssClass.getSections
        );

        data.forEach((section, index) => {
          if (!section) return;

          tabs.append(this.template.multi.tab(section, index, cloneTemplate));
          sectionsContainer.append(
            this.template.multi.section(section, index, cloneTemplate)
          );

          return;
        });

        cloneTemplate.querySelector(this.settings.cssClass.getTab).remove();
        cloneTemplate.querySelector(this.settings.cssClass.getSection).remove();

        elem.append(tabs, sectionsContainer);
      },
      section: (section, index, cloneTemplate) => {
        if (!section) return null;

        const sectionTemplate = cloneTemplate.querySelector(
          this.settings.cssClass.getSection
        );
        const cloneSectionTemplate = sectionTemplate.cloneNode(true);
        const cloneSectionTemplateRow = cloneSectionTemplate.querySelector(
          this.settings.cssClass.getSectionRow
        );
        const cloneSectionTemplateMore = cloneSectionTemplate
          .querySelector(this.settings.cssClass.getSectionMore)
          .querySelector("a");

        cloneSectionTemplate.dataset.index = index.toString();
        index === 0
          ? cloneSectionTemplate.classList.add(
              ...splitClassHelper(this.settings.cssClass.active)
            )
          : null;

        cloneSectionTemplateRow.insertAdjacentHTML(
          "afterbegin",
          section.dynamic_section
        );

        cloneSectionTemplateMore.setAttribute(
          "href",
          window.location.origin + this.currentCategories[index].url
        );
        cloneSectionTemplateMore.textContent = this.settings.txt.linksMoreAfter;

        return cloneSectionTemplate;
      },
      complete: (elem, data) => {
        const template = document.querySelector(
          this.settings.id.getMultiTemplate
        );
        const cloneTemplate = template.content.cloneNode(true);

        this.template.multi.tabs(elem, cloneTemplate, data);

        elem
          .querySelectorAll(`${this.settings.cssClass.getTab}`)
          .forEach((tab) => {
            this.events.tab(elem, tab);
          });
      },
    },
  };

  /** Eventy */
  this.events = {
    tab: (elem, tab) => {
      tab.addEventListener("click", (event) => {
        const activeTab = elem.querySelector(
          `${this.settings.cssClass.getTab}${this.settings.cssClass.getActive}`
        );
        const activeSection = elem.querySelector(
          `${this.settings.cssClass.getSection}${this.settings.cssClass.getActive}`
        );

        if (event.currentTarget === activeTab) return;

        const {
          dataset: { index },
        } = event.currentTarget;
        const targetSection = elem.querySelector(
          `${this.settings.cssClass.getSection}[data-index="${index}"]`
        );

        tab.classList.add(...splitClassHelper(this.settings.cssClass.active));
        activeTab.classList.remove(
          ...splitClassHelper(this.settings.cssClass.active)
        );
        targetSection.classList.add(
          ...splitClassHelper(this.settings.cssClass.active)
        );
        activeSection.classList.remove(
          ...splitClassHelper(this.settings.cssClass.active)
        );

        if (this.settings.config.slider) {
          if (app_shop.vars.view > 2) {
            $(
              targetSection.querySelector(this.settings.cssClass.getSectionRow)
              ).slick("refresh");
          } else {
            if (this.settings.config.sliderMobile) {
              $(
                targetSection.querySelector(this.settings.cssClass.getSectionRow)
                ).slick("refresh");
            }
          }
        }

        if (!this.settings.config.slider && app_shop.vars.bLazy.revalidate)
          app_shop.vars.bLazy.revalidate();
        
        return;
      });
    },
    slider: (section, desktop, mobile, storage) => {
      this.slider(
          section,
          desktop ? parseFloat(desktop) : null,
          mobile ? parseFloat(mobile) : null,
          storage
        );
    }
  };

  /** Obserwer dla lazy-load dla sekcji */
  this.observer = new IntersectionObserver((entries, observer) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        const target = entry.target;
        this.init(target);
        observer.unobserve(target);
      }
    });
  });

  /** Tworzenie gotowej struktury HTML dla pojedynczych/mnogich sekcji */
  this.create = {
    single: async (elem, sectionsArray) => {
      this.currentCategory = categoryData.find((obj) => {
        return obj.id === sectionsArray[0];
      });

      if (!this.currentCategory) {
        elem.remove();
        return;
      }

      elem.classList.add(...splitClassHelper(this.settings.cssClass.loader));
      const data = await this.get.section(
        this.currentCategory.url,
        this.currentCategory.id
      );

      if (!data) {
        elem.remove();
        return;
      }

      this.template.single.complete(elem, data);
      this.storage.response.push({
        id: this.currentCategory.id,
        url: this.currentCategory.url,
        data: data
      });

      const section = elem.querySelector(
        `${this.settings.cssClass.getSection}`
      );

      if (this.settings.config.addToFav) this.addToFav(section);
      if (this.settings.config.slider) this.events.slider(section, elem.dataset.desktop, elem.dataset.mobile, this.storage.sliders);

      const skeleton = elem.querySelector(
        `${this.settings.cssClass.getSkeleton}`
      );

      if (skeleton) skeleton.remove();
      elem.classList.remove(...splitClassHelper(this.settings.cssClass.loader));

      if (!this.settings.config.slider && app_shop.vars.bLazy.revalidate)
        app_shop.vars.bLazy.revalidate();

      if (callback) callback();

      return;
    },
    multi: async (elem, sectionsArray) => {
      this.currentCategories = categoryData.filter(
        (el) => sectionsArray.includes(el.id) && el.url !== ""
      );
      if (!this.currentCategories.length) {
        elem.remove();
        return;
      }

      elem.classList.add(...splitClassHelper(this.settings.cssClass.loader));

      const data = await this.get.sections(this.currentCategories);

      if (data.every((x) => x === false)) {
        elem.remove();
        return;
      }

      this.template.multi.complete(elem, data);

      const sectionsDataArray = [];
      const slidersDataArray = [];
      this.currentCategories.forEach((category, index) => {
        sectionsDataArray.push({
            id: category.id,
            url: category.url,
            data: data[index]
        })
      })

      const sectionsElements = elem.querySelectorAll(
        `${this.settings.cssClass.getSectionRow}`
      );

      sectionsElements.forEach((section) => {
        if (this.settings.config.addToFav) this.addToFav(section);
        if (this.settings.config.slider) this.events.slider(section, elem.dataset.desktop, elem.dataset.mobile, slidersDataArray);

        const skeleton = elem.querySelector(
          `${this.settings.cssClass.getSkeleton}`
        );
        if (skeleton) skeleton.remove();

        elem.classList.remove(
          ...splitClassHelper(this.settings.cssClass.loader)
        );

      });

      this.storage.response.push(sectionsDataArray);
      if (this.settings.config.slider) this.storage.sliders.push(slidersDataArray);

      if (!this.settings.config.slider && app_shop.vars.bLazy.revalidate)
        app_shop.vars.bLazy.revalidate();

      if (callback) callback();

      return;
    },
    start: async (elem) => {
      const sectionsId = elem.dataset.id;
      if (!sectionsId) return;

      const sectionsArray = sectionsId.split(",").map((x) => parseInt(x));

      if (!sectionsArray.length) return;

      /** Warunek dla ilości sekcji */
      if (sectionsArray.length === 1) {
        this.create.single(elem, sectionsArray);
      } else {
        this.create.multi(elem, sectionsArray);
      }

      return;
    },
  };

  /** Inicjalizacja */
  this.init = (elem) => {
    this.create.start(elem);
  };

  /** Inicjalizacja z opcją lazy-load */
  this.inView = (target) => {
    this.observer.observe(target);
  };

  return this;
}

/**
 * Dodawanie do ulubionych
 * @param {*} elem wrapper sekcji
 * @param {*} settings ustawienia przekazywane w funkcji 
 */
function AddToFavorite(elem, settings) {
  this.settings = settings;

  this.productsArray = elem.querySelectorAll(
    `${this.settings.cssClass.getProduct}`
  );

  const template = document.querySelector(
    this.settings.id.getDialogSizesTemplate
  );

  this.template = {
    button: template.content
      .querySelector(this.settings.cssClass.getDialogSizesButton)
      .cloneNode(true),
    dialog: () => {
      const content = document.querySelector(this.settings.id.getContent);
      const isDialog = content.querySelector(
        this.settings.cssClass.getDialogElement
      );
      if (isDialog) return isDialog;

      const cloneTemplate = template.content.cloneNode(true);
      const dialog = cloneTemplate.querySelector(
        this.settings.cssClass.getDialogElement
      );
      dialog.style.display = "none";
      this.close = dialog.querySelector(this.settings.cssClass.getDialogClose);
      this.sizes = dialog.querySelector(this.settings.cssClass.getDialogSizes);

      const top = dialog.querySelector(this.settings.cssClass.getDialogTop);
      const title = top.querySelector("strong");
      title.textContent = this.settings.txt.chooseSize;

      return dialog;
    },
  };

  this.events = {
    addSize: (sizeButton, dialogBackdrop, id) => {
      sizeButton.addEventListener("click", (e) => {
        e.preventDefault();
        e.stopPropagation();

        try {
          app_shop.fn.shoppingList.addProductToList([
            [id, sizeButton.getAttribute("data-type")],
          ]);
        } catch (error) {
          console.log(error);
        }

        dialogBackdrop.style.display = "none";
      });
    },
    showDialog: () => {
      this.productsArray.forEach((value, index) => {
        const sizesElementsArrayAll = this.productsArray[
          index
        ].querySelectorAll(`${this.settings.cssClass.getDialogSizesButton}`);

        /** Logika serduszka */
        const heartElement = this.productsArray[index].querySelector(
          `${this.settings.cssClass.getAddToListButton}`
        );

        heartElement.addEventListener("click", (e) => {
          addToFavorite(
            e,
            heartElement.getAttribute("data-product-id"),
            sizesElementsArrayAll
          );
        });
      });
    },
    dialogClick: (dialog, close) => {
      dialog.addEventListener("click", (e) => {
        if (e.target === dialog) {
          dialog.style.display = "none";
        }
      });
      close.addEventListener("click", (e) => {
        e.preventDefault();
        e.stopPropagation();
        dialog.style.display = "none";
      });
    },
  };

  const getSizesDialogWindow = () => {
    const dialog = this.template.dialog();
    document
      .querySelector(`${this.settings.id.getContent}`)
      ?.appendChild(dialog);

    this.events.dialogClick(dialog, this.close);

    return {
      dialogBackdrop: dialog,
      dialogSizes: this.sizes,
    };
  };

  const displaySizesDialogWindow = (id, sizesElementsArrayAll) => {
    if (sizesElementsArrayAll.length === 1) {
      app_shop.fn.shoppingList.addProductToList([
        [id, sizesElementsArrayAll[0].getAttribute("data-type")],
      ]);

      return;
    }

    const { dialogBackdrop, dialogSizes } = getSizesDialogWindow();
    dialogSizes.innerHTML = "";

    sizesElementsArrayAll.forEach((value, index) => {
      const sizeButton = this.template.button.cloneNode(true);
      sizeButton.setAttribute(
        "data-type",
        sizesElementsArrayAll[index].getAttribute("data-type")
      );
      sizeButton.textContent = sizesElementsArrayAll[index].textContent;

      /** Dodawanie do listy zakupowej */
      this.events.addSize(sizeButton, dialogBackdrop, id);

      dialogSizes?.appendChild(sizeButton);
      dialogBackdrop.style.display = "";
    });
  };

  const addToFavorite = (event, id, sizesElementsArrayAll) => {
    /** preventDefault() zapobiega odświeżaniu sie strony, a bez stopPropagation() popup z dodawaniem do listy zakupowej odrazu będzie się zamykać */
    event.preventDefault();
    event.stopPropagation();

    displaySizesDialogWindow(id, sizesElementsArrayAll);
  };

  this.events.showDialog(this.productsArray);
}
