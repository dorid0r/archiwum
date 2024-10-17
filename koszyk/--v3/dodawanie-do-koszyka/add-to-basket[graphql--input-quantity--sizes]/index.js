/**
 * Dodawanie do koszyka z opcją wyboru ilości i rozmiarów
 * @param selector główny kontener dla hotspotów ('.hotspot') lub listy towarów ('#search')
 */

function ProductBuy(selector) {
  this.selector = selector || {};

  this.vars = {
    productData: [],
  };

  this.options = {
    typingTimer: '',
    doneTypingInterval: 200,
    disableAddToBasketPopup: true,
    autoClose: true,
  };

  this.txt = {
    productBuyChooseSize: <iai:variable vid="Wybierz rozmiar" />,
    productBuyAddToBasket: <iai:variable vid="Dodaj do koszyka" />,
    productBuySuccessMessage: <iai:variable vid="Produkt został dodany do koszyka" />,
    productBuyErrorMessage: <iai:variable vid="Wystąpił błąd przy dodaniu do koszyka" />,
    productBuyErrorAvailibilityMessage: <iai:variable vid="Maksymalnie możesz dodać" /> + ": ",
    productBuyErrorInputNumValueMessage: <iai:variable vid="Minimalnie możesz dodać" /> + ": ",
  };

  this.getProductItemByID = (id) => this.vars.productData.find((item) => item?.id === id);

  this.productInfo = () => {
    const productsArr = Array.from(document.querySelectorAll(`${this.selector} .product`));

    this.vars.productData = productsArr.map((product) => {
      const productAddToBasketWrapper = product.querySelector('.product__buy_section .product__buy_number');
      if (!productAddToBasketWrapper) return null;

      return {
        id: productAddToBasketWrapper.getAttribute('data-id'),
        availableAmount: parseInt(productAddToBasketWrapper.getAttribute('data-amount'), 10) === -1 ? Infinity : parseInt(productAddToBasketWrapper.getAttribute('data-amount'), 10),
        quantity: parseInt(productAddToBasketWrapper.getAttribute('data-quantity'), 10),
        unitSellby: parseInt(productAddToBasketWrapper.getAttribute('data-sellby'), 10),
        size: productAddToBasketWrapper.getAttribute('data-size'),
        unit: productAddToBasketWrapper.getAttribute('data-unit'),
      };
    });
  };

  this.mutationQuery = (productID) => {
    const { id, size, quantity } = this.getProductItemByID(productID);

    const queryGraphQL = {
      query: `
            mutation addProductsToBasket{
              addProductsToBasket(ProductInput : [{id: ${id}, size: "${size}", quantity: ${quantity}}]){
                status,
                results{
                    status,
                    error{
                        code,
                        message
                    }
                }
            }
        }`,
    };
    return queryGraphQL;
  };

  this.fetchData = async (productSelector, currentProductID) => {
    productSelector.querySelector(`.product__buy_button[data-id="${currentProductID}"]`).classList.add('--loading');

    try {
      const response = await fetch(
        app_shop?.urls?.graphql || '/graphql/v1/',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json',
          },
          body: JSON.stringify(this.mutationQuery(currentProductID)),
        },
      );
      if (app_shop?.graphql?.trackingEvents) await app_shop.graphql.trackingEvents(response);
      const dataJson = await response.json();
      return dataJson;
    } catch (error) {
      console.error('AJAX fetchDataGraphQL() Error:', error);
      return error;
    }
  };

  this.getInfo = async (productSelector, currentProductID) => {
    await this.fetchData(productSelector, currentProductID).then((response) => {
      const responseData = response?.data?.addProductsToBasket || {};
      productSelector
        .querySelector(`.product__buy_button[data-id="${currentProductID}"]`).classList.remove('--loading');

      if (!responseData || responseData.status !== 'success' || responseData.results[0].error !== null || responseData.results[0].status === 'error') {
        Alertek.Error(this.txt.productBuyErrorMessage);
        console.error(responseData.results[0].error.message);
        return;
      }

      if (this.options.disableAddToBasketPopup) {
        fetch('/return.php');
      }

      if (typeof menu_basket_cache === 'function') {
        menu_basket_cache();
      } else if (typeof app_shop.fn.menu_basket_cache === 'function') {
        app_shop.fn.menu_basket_cache();
      }

      Alertek.Success(this.txt.productBuySuccessMessage);
      if (productSelector.classList.contains('--show-sizes')) productSelector.classList.remove('--show-sizes');

      this.clearSelectedSize(productSelector);
    });
  };

  this.productBuy = () => {
    const productBuySectionsArr = Array.from(document.querySelectorAll('.product__buy_section:not(.--updated):not(.--link)'));

    const productBuySections = productBuySectionsArr.map((section) => {
      const submitButton = section.querySelector('.product__buy_button:not(.--updated)');
      const currentProductID = section.querySelector('.product__buy_number').getAttribute('data-id');
      const productSelector = section.closest('.product');
      if (this.options.autoClose) productSelector.classList.add('--show-sizes-label');

      section.classList.add('--updated');

      this.initNumber(
        section.querySelector('.product__buy_number_wrapper'),
        currentProductID,
      );

      this.updateSize(productSelector, currentProductID, submitButton, section);
      this.closeSizesWrapper();

      submitButton.addEventListener('click', (e) => {
        e.preventDefault();
        if (section.classList.contains('--sizes')) {
          if (this.options.autoClose) {
            productSelector?.classList.add('--show-sizes');
            Alertek.Info(this.txt.productBuyChooseSize);
          } else if (productSelector && productSelector.classList.contains('--show-sizes')) {
            if (productSelector.classList.contains('--selected-size')) this.getInfo(productSelector, currentProductID, submitButton, section);
          } else {
            productSelector?.classList.add('--show-sizes');
            if (!productSelector.classList.contains('--selected-size')) Alertek.Info(this.txt.productBuyChooseSize);
            submitButton.textContent = this.txt.productBuyChooseSize;
          }
        } else {
          this.getInfo(productSelector, currentProductID, submitButton, section);
        }
        submitButton.classList.add('--updated');
      });

      return section;
    });

    return productBuySections;
  };

  this.updateSize = (productSelector, id, submitButton, section) => {
    const sizesWrapper = productSelector.querySelector('.product__sizes');
    if (!sizesWrapper) return;
    const sizeInputs = sizesWrapper.querySelectorAll('.product__size_input');
    sizeInputs.forEach((input) => {
      input.addEventListener('change', () => {
        const currentProduct = this.getProductItemByID(id);
        currentProduct.size = input.value;
        currentProduct.availableAmount = parseInt(input.getAttribute('data-amount'), 10) === -1 ? Infinity : parseInt(input.getAttribute('data-amount'), 10);
        if (this.options.autoClose) {
          this.getInfo(productSelector, id, submitButton, section);
          productSelector.classList.remove('--show-sizes');
        } else {
          productSelector.classList.add('--selected-size');
        }
        submitButton.textContent = this.txt.productBuyAddToBasket;
      });
    });
  };

  this.clearSelectedSize = (productSelector) => {
    const sizesWrapper = productSelector.querySelector('.product__sizes');
    if (!sizesWrapper) return;

    const sizeInputs = sizesWrapper.querySelectorAll('.product__size_input');
    sizeInputs.forEach((sizeInput) => {
      sizeInput.checked = false;
    });
  };

  this.closeSizesWrapper = () => {
    const selectorElements = document.querySelectorAll(this.selector);
    document.addEventListener('click', (event) => {
      const clickedProduct = event.target.closest('.product');
      selectorElements.forEach((element) => {
        const products = element.querySelectorAll('.product');
        products.forEach((product) => {
          if (product !== clickedProduct) {
            product.classList.remove('--show-sizes', '--selected-size');
            this.clearSelectedSize(product);
            const submitButton = product.querySelector('.product__buy_button');
            submitButton
              && (submitButton.textContent = this.txt.productBuyAddToBasket);
          }
        });
      });
    });
  };

  this.validateNumber = (numberInput, numberInputValue, productID) => {
    const currentProduct = this.getProductItemByID(productID);
    const { availableAmount, unit, unitSellby } = currentProduct;

    if (Number.isNaN(numberInputValue)) {
      numberInput.value = 1;
      currentProduct.quantity = 1;
      return;
    }

    if (numberInputValue < 1) {
      numberInput.value = parseInt(unitSellby, 10);
      currentProduct.quantity = parseInt(unitSellby, 10);
      Alertek.Error(`${this.txt.productBuyErrorInputNumValueMessage} ${unitSellby} ${unit}`);
      return;
    }

    if (numberInputValue > availableAmount) {
      numberInput.value = availableAmount;
      currentProduct.quantity = availableAmount;
      Alertek.Error(`${this.txt.productBuyErrorAvailibilityMessage} ${availableAmount} ${unit}`);
      return;
    }

    currentProduct.quantity = parseInt(numberInputValue, 10);
  };

  this.initNumber = (wrapper, productID) => {
    const { unitSellby } = this.getProductItemByID(productID);
    const numberInput = wrapper.querySelector('.product__buy_number');
    const numberDown = wrapper.querySelector('.product__buy_number_down');
    const numberUp = wrapper.querySelector('.product__buy_number_up');

    if (numberInput) {
      this.events.numberInput(numberInput, productID);
    }

    if (numberDown) {
      this.events.numberChange(
        numberInput,
        numberDown,
        productID,
        unitSellby,
        (numberValue) => numberValue - unitSellby,
      );
    }

    if (numberUp) {
      this.events.numberChange(
        numberInput,
        numberUp,
        productID,
        unitSellby,
        (numberValue) => numberValue + unitSellby,
      );
    }
  };

  this.events = {
    numberInput: (numberInput, productID) => {
      numberInput.addEventListener('keyup', (e) => {
        clearTimeout(this.options.typingTimer);

        this.options.typingTimer = setTimeout(() => {
          if (e.target.value !== '') {
            this.validateNumber(numberInput, numberInput.value, productID);
          }
        }, this.options.doneTypingInterval);
      });

      numberInput.addEventListener('blur', (e) => {
        if (e.target.value === '') {
          this.validateNumber(numberInput, numberInput.value, productID);
        }
      });
    },

    numberChange: (numberInput, numberTarget, productID, unitSellby, callback) => {
      numberTarget.addEventListener('click', (e) => {
        e.preventDefault();
        numberInput.value = callback(
          parseFloat(numberInput.value, 10),
          parseFloat(unitSellby),
        );
        this.validateNumber(numberInput, numberInput.value, productID);
      });
    },
  };

  this.init = () => {
    this.productInfo();

    if (this.vars.productData.length) {
      this.productBuy();
    }
  };
}
