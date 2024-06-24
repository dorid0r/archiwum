function FavoriteProductList(props) {
  this.props = props;

  this.literals = {
    alertError: (
      <iai:variable vid="Wystąpił błąd przy dodaniu produktu do listy zakupowej" />
    ),
  };

  this.defaultSettings = {
    parentSelector: '#content',
    favoriteSelector: '.product__favorite',
    favoriteLinkSelector: '.product__favorite_link',
    sizes: {
      wrapperSelector: '.product__favorite_sizes.--wrapper',
      itemLinkSelector: '.product__favorite_sizes.--item',
      appendToSelector: '.product__icon',
    },
  };

  this.settings = {
    ...this.defaultSettings,
    ...this.props,
  };

  this.favoriteLinkSelector = this.settings.favoriteLinkSelector;
  this.sizes = this.settings.sizes;

  this.init = () => {
    const { appendToSelector } = this.sizes;
    this.favoriteNodeList = document.querySelectorAll(`${this.settings.parentSelector} ${this.settings.favoriteSelector}:not(.--updated)`);

    if (!this.favoriteNodeList) {
      return;
    }

    Array.from(this.favoriteNodeList).forEach((item) => {
      item.classList.add('--updated');
      const productID = item.getAttribute('data-product-id');
      const productOneSize = item.getAttribute('data-product-size');
      const isProductOneSize = !!productOneSize;
      const link = item.querySelector(this.favoriteLinkSelector);

      if (!productID || !link) {
        return;
      }

      // Uruchamia się w przypadku gdy produkt ma tylko jeden rozmiar
      if (isProductOneSize || (!this.sizes && productOneSize)) {
        this.addLinkEvent(link, () => this.favoriteProductMutate(productID, productOneSize));
        return;
      }

      // Uruchamia się gdy produkt ma więcej niż 1 rozmiar
      const sizeWrapper = item.querySelector(this.sizes.wrapperSelector);
      const sizeLinkNodeList = sizeWrapper?.querySelectorAll(this.sizes.itemLinkSelector);

      if (!sizeWrapper || !sizeLinkNodeList) {
        return;
      }

      // Po kliknięciu odkrywa wrapper z dostępnymi rozmiarami
      this.addLinkEvent(link, () => sizeWrapper.classList.toggle('--visible'));

      // Obsługa kliknięcia w kafelek rozmiarowy
      this.addProductSizeLinksEvent(sizeLinkNodeList, productID, sizeWrapper);

      // Przeniesienie wrapperu z rozmiarami do podanego selectoru
      if (appendToSelector) {
        this.sizesAppendTo(item, sizeWrapper);
      }
    });
  };

  this.addProductSizeLinksEvent = (sizeLinkNodeList, productID, sizeWrapper) => {
    sizeLinkNodeList.forEach((sizeLink) => {
      const productSizeType = sizeLink.getAttribute('data-type');

      if (!productSizeType) {
        return;
      }

      this.addLinkEvent(sizeLink, () => {
        this.favoriteProductMutate(productID, productSizeType);
        sizeWrapper.classList.toggle('--visible');
      });
    });
  };

  this.addLinkEvent = (link, callback) => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      callback();
    });
  };

  this.favoriteProductMutate = (productId, productSize) => {
    try {
      app_shop.fn.shoppingList.addProductToList([[productId, productSize]]);
    } catch (err) {
      Alertek.Error(this.literals.alertError);
    }
  };

  this.sizesAppendTo = (item, sizeWrapper) => {
    const { appendToSelector } = this.sizes;
    const product = item.closest('.product');
    const wrapper = product.querySelector(appendToSelector);

    if (!wrapper) {
      return;
    }

    wrapper.append(sizeWrapper);
  };
}
