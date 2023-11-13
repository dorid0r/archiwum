  //podział składowych kolekcji na osobne produkty w koszyku Start

/**
  * Dzielenie kolekcji na składowe przekazywane do koszyka jako osobne produkty
  * @param {object} params - obiekt z wszystkimi callback'ami
  * @param {string} addToBasketButton - selektor dla inputów dodania do koszyka na karcie towaru
  * @param {string} projectorForm - selektor dla formularza na karcie towaru
  * @param {string} bundleItems - selektor dla formularza na karcie towaru
  * @param {string} bundleInput - selektor dla inputa z ilością skłądowej
  * @param {string} bundleProductId - selektor dla inputa z id składowej
  * @param {string} bundleProductSize - selektor dla inputa z size składowej
  * @param {string} subscriptionBtn - selektor przycisku dodania do koszyka dla subskrypcji
  * @param {boolean} subscriptionStatus - włączenie obsługi subskrypcji
  * @param {function} responseCallback - callback przy wysłaniu danych
  * @param {function} beforeAddToBasketCallback - callback przed dodaniem do koszyka
  */
 const BundleSplit = function BundleSplit(param) {
    this.param = param || {};
  
    /**
       Obsługa zdarzenia po dodaniu produktu do koszyka
      */
    this.response = (data) => {
      data.url.includes('return.php')
        ? window.location.href = data?.url
        : this?.responseCallback(this.productIdList);
    };
  
    /**
       Przygotowanie obiektu produktu
      */
    this.setProductParams = (product) => {
      const itemNumber = product.querySelector(this.bundleInput).value;
      const productParams = {
        product: product.querySelector(this.bundleProductId)?.value,
        size: product.querySelector(this.bundleProductSize)?.value,
        number: itemNumber,
        additional: '',
      };
  
      return productParams;
    };
  
    /**
       Wysłanie nowego forma z listą produktów
      */
  
    this.getData = async (products) => fetch('/basketchange.php?type=multiproduct', {
      method: 'POST',
      body: products,
    });
  
    /**
       Sterowanie  subskrypcją
      */
    this.subscriptionMode = (onOff, btn, products, index) => {
      if (onOff) {
        btn.classList.contains(this.subscriptionBtn) ? products.set(`subscription[${index}]`, 1) : '';
      }
    };
  
    /**
       Zatrzymanie standardowego dodania do koszyka, uzupełnienie forma produktami
      */
    this.addToBasketController = async (e, btn) => {
      e.preventDefault();
      if (this.beforeAddToBasketCallback) this.beforeAddToBasketCallback();
  
      const products = new FormData();
      products.set('mode', 1);
  
     
  
      this.productIdList = [];
      this.bundleItems.forEach((item, i) => {
        const productParams = this.setProductParams(item);
        this.subscriptionMode(this.subscriptionStatus, btn, products, i);
        Number(item.querySelector(this.bundleInput).value) > 0
        ? this.productIdList.push(productParams.product) : '';

        Object.keys(productParams).forEach((el) => {
          Number(item.querySelector(this.bundleInput).value) > 0
            ? products.set(`${el}[${i}]`, productParams[el]) : '';
        });
      });
      try {
        const dataSend = await this.getData(products);
        this.response(dataSend);
      } catch (error) {
        console.error('BundleSplit Error:', error);
        return false;
      }
      return false;
    };
  
    this.initEvents = () => {
      /**
       dodanie eventu dla przycisku dodaj do koszyka
      */
      this.addToBasketButton.forEach((btn) => {
        btn.addEventListener('click', (e) => { this.addToBasketController(e, btn); });
      });
    };

    this.init = () => {
      const {
        addToBasketButton,
        projectorForm,
        bundleItems,
        bundleInput,
        bundleProductId,
        bundleProductSize,
        subscriptionBtn,
        subscriptionStatus,
        responseCallback,
        beforeAddToBasketCallback,
      } = this.param;
  
      this.addToBasketButton = addToBasketButton
        ? document.querySelectorAll(addToBasketButton)
        : document.querySelectorAll('#projector_button_basket');
  
      this.projectorForm = projectorForm
        ? document.querySelector(projectorForm)
        : document.querySelector('#projector_form');
  
      this.bundleItems = bundleItems
        ? this.projectorForm.querySelectorAll(bundleItems)
        : this.projectorForm.querySelectorAll('.projector_bundle__item');
  
      this.bundleInput = bundleInput || '.projector_buy__bundle_input';
  
      this.bundleProductId = bundleProductId || '.projector_bundle__product_id';
  
      this.bundleProductSize = bundleProductSize || '.projector_bundle__product_size';
  
      this.subscriptionBtn = subscriptionBtn || '--subscription-btn';
  
      this.subscriptionStatus = subscriptionStatus || true;
  
      responseCallback ? this.responseCallback = responseCallback : '';
  
      this.beforeAddToBasketCallback = beforeAddToBasketCallback || false;
  
      this.initEvents();
    };
  };

/**
  wywołanie toplayera po dodaniu do koszyka
*/
app_shop.run(function ProjectorBundleSplit() {
  const toplayerProductVisibility = (productIdList) => {
    const toplayerProductBox = document.querySelectorAll('.tl-productBox');
    productIdList.forEach(id => {
        toplayerProductBox.forEach(productBox => {
            productBox.dataset.productId == id
            ? productBox.classList.add('--active')
            : '';
        })
    })
  }
  
  app_shop.fn.bundleSplit = new BundleSplit({
    responseCallback: (productIdList) => {
      app_shop.fn.showBasketDialog();
      toplayerProductVisibility(productIdList);
      app_shop.fn.updateTopBasket();
      app_shop.vars.bLazy.revalidate();
    },
  });
  app_shop.fn.bundleSplit.init();
}, "all", '.projector_bundle');
  //podział składowych kolekcji na osobne produkty w koszyku End
