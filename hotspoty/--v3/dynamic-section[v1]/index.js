/**
 * Dynamicznie sekcje pobierające produkty z navigation na podstawie ID
 * @param {object} params obiekt z domyślnymi ustawieniami klass, tagu nagłowka sekcji, strzałek dla slidera
 * @param {*} callback
 * @returns
 */
 function DynamicSections(params, callback) {
  params && typeof params === "object" ? params : (params = {});

  // Funkcja pomocnicza do dzielenia sklas podczas używania metody classList.add()
  const splitClass = (text) => {
    if (text) return text.split(" ");
  };

  // Ustawienia dla klas, literałów i slicka
  this.settings = {
    cssClass: {
      dialogElement: params.cssClass?.dialogElement || "sl_dialog sizes_dialog_search",
      dialogWrapper: params.cssClass?.dialogWrapper || "sl_choose__wrapper sl_dialog__wrapper p-4 p-md-5",
      dialogClose: params.cssClass?.dialogClose || "sizes_dialog --close",
      dialogCloseIcon: params.cssClass?.dialogCloseIcon || "icon-x",
      dialogTop: params.cssClass?.dialogTop || "sl_choose__item --top mb-2",
      dialogSizes: params.cssClass?.dialogSizes || "sl_choose__item --sizes",
      dialogSizesButton: params.cssClass?.dialogSizesButton || "product__sizes__button",
      getDialogSizesButton:
      params.cssClass?.getDialogSizesButton || ".product__sizes .product__sizes__sub .product__sizes__button",
      getDialogSizes: params.cssClass?.getDialogSizes || ".sl_choose__item.--sizes",
      getAddToListButton: params.cssClass?.getAddToListButton || ".product__favorite",
      getProduct: params.cssClass?.getProduct || ".product",
      tabs: params.cssClass?.tabs || "hotspot__dynamic__tabs",
      tab: params.cssClass?.tab || "hotspot__dynamic__tab",
      getTab: params.cssClass?.getTab || ".hotspot__dynamic__tab",
      sections: params.cssClass?.sections || "hotspot__dynamic__sections",
      section: params.cssClass?.section || "hotspot__dynamic__section",
      getSection: params.cssClass?.getSection || ".hotspot__dynamic__section",
      sectionRow: params.cssClass?.sectionRow || "hotspot__dynamic__section__row",
      getSectionRow: params.cssClass?.getSectionRow || ".hotspot__dynamic__section__row",
      sectionMore: params.cssClass?.sectionMore || "hotspot__dynamic__section__more",
      active: params.cssClass?.active || "--active",
      getActive: params.cssClass?.getActive || ".--active",
      getSlickSlider: params.cssClass?.getSlickSlider || ".slick-slider",
      loader: params.cssClass?.loader || "load-content",
      getSkeleton: params.cssClass?.getSkeleton || ".hotspot__dynamic__skeleton",
      header: params.cssClass?.header || "headline",
      headerName: params.cssClass?.headerName || "headline__name",
      headerAfter: params.cssClass?.headerAfter || "headline__after",
    },
    id: {
      getContent: params.id?.getContent || "#content",
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
        params.slick?.settings?.prevArrow || "<a class='slick-prev' href=''><i class='icon-angle-left'></i></a>",
        nextArrow:
        params.slick?.settings?.nextArrow || "<a class='slick-next' href=''><i class='icon-angle-right'></i></a>",
      },
    },
  };

  // Dodawanie do ulubionych
  this.addToFav = (elem) => {
    const getSizesDialogWindow = () => {
      let dialog;

      if (!dialog) {
        //tworzymy okno dialogowe
        dialog = document.createElement("div");
        dialog.className = `${this.settings.cssClass.dialogElement}`;
        dialog.style.display = "none";

        let wrapper = document.createElement("div");
        wrapper.className = `${this.settings.cssClass.dialogWrapper}`;
        dialog.appendChild(wrapper);

        let close = document.createElement("a");
        close.className = `${this.settings.cssClass.dialogClose}`;
        close.addEventListener("click", (e) => {
          e.preventDefault();
          e.stopPropagation();
          dialog.style.display = "none";
        });
        wrapper.appendChild(close);

        let icon = document.createElement("i");
        icon.className = `${this.settings.cssClass.dialogCloseIcon}`;
        close.appendChild(icon);

        let top = document.createElement("div");
        top.className = `${this.settings.cssClass.dialogTop}`;
        wrapper.appendChild(top);

        let title = document.createElement("strong");
        title.textContent = app_shop.txt.txt_74629_8;
        top.appendChild(title);

        let sizes = document.createElement("div");
        sizes.className = `${this.settings.cssClass.dialogSizes}`;
        wrapper.appendChild(sizes);

        document
          .querySelector(`${this.settings.id.getContent}`)
          ?.appendChild(dialog);

        //event listener'y
        dialog.addEventListener("click", (e) => {
          if (e.target === dialog) {
            dialog.style.display = "none";
          }
        });
      }

      return {
        dialogBackdrop: dialog,
        dialogSizes: dialog.querySelector(
          `${this.settings.cssClass.getDialogSizes}`
        ),
      };
    };

    const productsArray = elem.querySelectorAll(
      `${this.settings.cssClass.getProduct}`
    );

    const displaySizesDialogWindow = (id, sizesElementsArrayAll) => {
      if (sizesElementsArrayAll.length === 1) {
        app_shop.fn.shoppingList.addProductToList([
          [id, sizesElementsArrayAll[0].getAttribute("data-type")],
        ]);

        return;
      }

      const { dialogBackdrop, dialogSizes } = getSizesDialogWindow();

      while (dialogSizes?.firstChild) {
        if (dialogSizes.lastChild)
          dialogSizes.removeChild(dialogSizes.lastChild);
      }

      for (let i = 0; i < sizesElementsArrayAll.length; i++) {
        let sizeButton = document.createElement("a");
        sizeButton.classList.add(
          ...splitClass(this.settings.cssClass.dialogSizesButton)
        );
        sizeButton.setAttribute(
          "data-type",
          sizesElementsArrayAll[i].getAttribute("data-type")
        );
        sizeButton.textContent = sizesElementsArrayAll[i].textContent;

        //dodawanie do listy zakupowej
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

        dialogSizes?.appendChild(sizeButton);
        dialogBackdrop.style.display = "";
      }
    };

    const addToFavorite = (event, id, sizesElementsArrayAll) => {
      //preventDefault() zapobiega odświeżaniu sie strony, a bez stopPropagation() popup z dodawaniem do listy zakupowej odrazu będzie się zamykać
      event.preventDefault();
      event.stopPropagation();

      displaySizesDialogWindow(id, sizesElementsArrayAll);
    };

    for (let i = 0; i < productsArray.length; i++) {
      let sizesElementsArrayAll = productsArray[i].querySelectorAll(
        `${this.settings.cssClass.getDialogSizesButton}`
      );

      //logika serduszka
      let heartElement = productsArray[i].querySelector(
        `${this.settings.cssClass.getAddToListButton}`
      );
      heartElement.addEventListener("click", (e) => {
        addToFavorite(
          e,
          heartElement.getAttribute("data-product-id"),
          sizesElementsArrayAll
        );
      });
    }
  };

  /**
   * Tworzenie slidera (slick-slider)
   * @param {*} wrapper wrapper dla produktów w sekcji
   * @param {*} sliderItemsDesktop ilość elementów widocznych w widoku desktop (domyślnie 4) - przekazywane w atrybucie data-desktop w głównym wrapperze (elem); przyjmuje wartości zmiennoprzecinkowe
   * @param {*} sliderItemsMobile  ilość elementów widocznych w widoku mobile (domyślnie 2) - przekazywane w atrybucie data-desktop w głównym wrapperze (elem); przyjmuje wartości zmiennoprzecinkowe
   */
  this.slider = (wrapper, sliderItemsDesktop, sliderItemsMobile) => {
    $(wrapper).slick({
      slidesToShow: sliderItemsDesktop ? parseFloat(sliderItemsDesktop) : 4,
      responsive: [
        {
          breakpoint: this.settings.slick.breakpoint.md,
          settings: {
            slidesToShow: sliderItemsMobile ? parseFloat(sliderItemsMobile) : 2,
          },
        },
      ],
      ...this.settings.slick.settings,
    });

    $(wrapper).on("afterChange", () => {
      if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
    });
  };

  // Pobieranie listy produktów dla konkretnej kategorii
  this.getSection = async function sectionProducts(url) {
    const response = await fetch(
      `${url}?shop_xml=1&get_ajax_items=dynamic_section`
    );
    const responseClone = response.clone();
    const test = await responseClone.text();

    if (test.includes("!DOCTYPE html")) {
      return false;
    } else {
      return response.json();
    }
  };

  // Szablon dla pojedynczej sekcji
  this.singleTemplate = (elem, data) => {
    const sectionsHeader = elem.dataset.header;
    const headerElem = document.createElement(
      `${this.settings.section.headerTag}`
    );
    const headerLink = document.createElement("a");
    const headerName = document.createElement("span");
    const headerAfter = document.createElement("span");

    headerLink.classList.add(...splitClass(this.settings.cssClass.header));
    headerLink.setAttribute(
      "href",
      window.location.origin + this.currentCategory.url
    );

    headerName.classList.add(...splitClass(this.settings.cssClass.headerName));
    headerName.textContent = this.currentCategory.name;
    headerAfter.classList.add(
      ...splitClass(this.settings.cssClass.headerAfter)
    );
    headerAfter.textContent = app_shop.txt.linkMoreAfter;

    headerLink.append(headerName, headerAfter);
    headerElem.append(headerLink);

    if (sectionsHeader !== "false") elem.append(headerElem);

    const sectionElem = document.createElement("div");
    sectionElem.classList.add(...splitClass(this.settings.cssClass.section));
    sectionElem.insertAdjacentHTML("afterbegin", data.dynamic_section);

    elem.append(sectionElem);
  };

  // Szablon dla mnogiej liczby sekcji (zakładki)
  this.tabsTemplate = (elem, data) => {
    const tabs = document.createElement("div");
    tabs.classList.add(...splitClass(this.settings.cssClass.tabs));

    const sections = document.createElement("div");
    sections.classList.add(...splitClass(this.settings.cssClass.sections));

    data.map((section, index) => {
      if (!section) return;

      const tab = document.createElement("div");
      const tabSpan = document.createElement("span");
      tab.dataset.index = index.toString();
      index === 0
        ? tab.classList.add(
            ...splitClass(this.settings.cssClass.tab),
            ...splitClass(this.settings.cssClass.active)
          )
        : tab.classList.add(...splitClass(this.settings.cssClass.tab));
      tabSpan.append(this.currentCategories[index].name);
      tab.append(tabSpan);
      tabs.append(tab);

      const sectionElem = document.createElement("div");
      sectionElem.dataset.index = index.toString();
      index === 0
        ? sectionElem.classList.add(
            ...splitClass(this.settings.cssClass.section),
            ...splitClass(this.settings.cssClass.active)
          )
        : sectionElem.classList.add(
            ...splitClass(this.settings.cssClass.section)
          );
      const sectionElemRow = document.createElement("div");
      sectionElemRow.classList.add(
        ...splitClass(this.settings.cssClass.sectionRow)
      );
      sectionElemRow.insertAdjacentHTML("afterbegin", section.dynamic_section);
      sectionElem.append(sectionElemRow);

      const sectionMore = document.createElement("div");
      const sectionMoreLink = document.createElement("a");
      sectionMore.classList.add(
        ...splitClass(this.settings.cssClass.sectionMore)
      );
      sectionMoreLink.setAttribute(
        "href",
        window.location.origin + this.currentCategories[index].url
      );
      sectionMoreLink.textContent = app_shop.txt.linksMoreAfter;
      sectionMore.append(sectionMoreLink);
      sectionElem.append(sectionMore);

      sections.append(sectionElem);
    });

    elem.append(tabs, sections);

    const tabsElements = elem.querySelectorAll(
      `${this.settings.cssClass.getTab}`
    );

    tabsElements.forEach((tab) => {
      tab.addEventListener("click", (e) => {
        const activeTab = elem.querySelector(
          `${this.settings.cssClass.getTab}${this.settings.cssClass.getActive}`
        );
        const activeSection = elem.querySelector(
          `${this.settings.cssClass.getSection}${this.settings.cssClass.getActive}`
        );

        if (e.target === activeTab) return;

        const tabTarget = e.target.closest("[data-index]");
        const index = tabTarget.dataset.index;
       
        const targetSection = elem.querySelector(
          `${this.settings.cssClass.getSection}[data-index="${index}"]`
        );

        tab.classList.add(...splitClass(this.settings.cssClass.active));
        activeTab.classList.remove(
          ...splitClass(this.settings.cssClass.active)
        );
        targetSection.classList.add(
          ...splitClass(this.settings.cssClass.active)
        );
        activeSection.classList.remove(
          ...splitClass(this.settings.cssClass.active)
        );

        const targetSectionSlider = targetSection.querySelector(
          `${this.settings.cssClass.getSlickSlider}`
        );
        $(targetSectionSlider).slick("refresh");
      });
    });
  };

  this.createSection = async (elem) => {
    const sectionsId = elem.dataset.id;

    if (!sectionsId) return;

    const sectionsArray = sectionsId.split(",").map((x) => parseInt(x));

    // Pojedyncza sekcja
    if (sectionsArray.length === 1) {
      this.currentCategory = categoryData.find((obj) => {
        return obj.id === sectionsArray[0];
      });

      elem.classList.add(...splitClass(this.settings.cssClass.loader));
      const data = await this.getSection(this.currentCategory.url);

      if (!this.currentCategory || !data) {
        elem.remove();
        return false;
      }

      this.singleTemplate(elem, data);

      const section = elem.querySelector(
        `${this.settings.cssClass.getSection}`
      );

      this.addToFav(section);
      this.slider(
        section,
        elem.dataset.desktop ? parseFloat(elem.dataset.desktop) : null,
        elem.dataset.mobile ? parseFloat(elem.dataset.mobile) : null
      );

      const skeleton = elem.querySelector(
        `${this.settings.cssClass.getSkeleton}`
      );

      if (skeleton) skeleton.remove();
      elem.classList.remove(...splitClass(this.settings.cssClass.loader));
    }

    // Sekcja z zakładkami
    if (sectionsArray.length > 1) {
      this.currentCategories = categoryData.filter((el) =>
        sectionsArray.includes(el.id)
      );
      if (!this.currentCategories.length) {
        elem.remove();
        return false;
      }

      elem.classList.add(...splitClass(this.settings.cssClass.loader));

      const sectionsData = async () => {
        const requests = this.currentCategories.map(async (category) => {
          const data = this.getSection(category.url);
          return data;
        });
        return Promise.all(requests);
      };

      const data = await sectionsData();

      if (data.every((x) => x === false)) {
        elem.remove();
        return false;
      }

      this.tabsTemplate(elem, data);

      const sectionsElements = elem.querySelectorAll(
        `${this.settings.cssClass.getSectionRow}`
      );
      sectionsElements.forEach((section) => {
        this.addToFav(section);
        this.slider(
          section,
          elem.dataset.desktop ? parseFloat(elem.dataset.desktop) : null,
          elem.dataset.mobile ? parseFloat(elem.dataset.mobile) : null
        );

        const skeleton = elem.querySelector(
          `${this.settings.cssClass.getSkeleton}`
        );
        if (skeleton) skeleton.remove();

        elem.classList.remove(...splitClass(this.settings.cssClass.loader));
      });
    }

    if (callback) callback();
  };

  // Inicjacja dynamicznych sekcji
  const init = (elem) => {
    this.createSection(elem);
  };

  // Inicjacja lazy-load dla dynamicznych sekcji przy użyciu IntersectionObserver
  const inView = (target) => {
    const inViewObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const target = entry.target;
          init(target);
          observer.unobserve(target);
        }
      });
    });

    inViewObserver.observe(target);
  };

  return {
    inView,
    init,
  };
}
