function ProductBuy(selector) {
  this.selector = selector || {};

  this.vars = {
    productData: [],
  };

  this.options = {
    typingTimer: '',
    doneTypingInterval: 200,
    disableAddToBasketPopup: true,
  };

  this.txt = {
    productBuySuccessMessage: <iai:variable vid="Produkt został dodany do koszyka" />,
    productBuyErrorMessage: <iai:variable vid="Wystąpił błąd przy dodaniu do koszyka" />,
    productBuyErrorAvailibilityMessage: <iai:variable vid="Maksymalnie możesz dodać" /> + ": ",
    productBuyErrorInputNumValueMessage: <iai:variable vid="Minimalnie możesz dodać" /> + ": ",
  };

  this.getProductItemByID = (id) => this.vars.productData.find((item) => item?.id === id);

  this.productInfo = () => {
    const productsArr = Array.from(document.querySelectorAll(`${this.selector} .product`));

    this.vars.productData = productsArr.map((product) => {
      if (!product.querySelector('.product_buy_section .product_buy__number')) {
        return null;
      }

      const productAddToBasketWrapper = product.querySelector('.product_buy_section .product_buy__number');

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

  this.productBuy = () => {
    const productBuySectionsArr = Array.from(document.querySelectorAll('.product_buy_section:not(.--updated):not(.--link)'));

    const productBuySections = productBuySectionsArr.map((section) => {
      const addButton = section.querySelector('.product_buy__button:not(.--updated)');
      const currentProductID = section.querySelector('.product_buy__number').getAttribute('data-id');

      section.classList.add('--updated');

      const fetchData = async () => {
        section.querySelector(`.product_buy__button[data-id="${currentProductID}"]`).classList.add('--loading');

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
          const dataJson = await response.json();
          return dataJson;
        } catch (error) {
          console.error('AJAX fetchDataGraphQL() Error:', error);
          return error;
        }
      };

      const getInfo = async () => {
        await fetchData().then((response) => {
          const responseData = response?.data?.addProductsToBasket || {};
          section
            .querySelector(`.product_buy__button[data-id="${currentProductID}"]`).classList.remove('--loading');

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
          }

          else if (typeof app_shop.fn.menu_basket_cache === 'function') { 
            app_shop.fn.menu_basket_cache();
          }

          Alertek.Success(this.txt.productBuySuccessMessage);
        });
      };

      this.initNumber(
        section.querySelector('.product_buy__number_wrapper'),
        currentProductID,
      );

      addButton.addEventListener('click', (e) => {
        e.preventDefault();
        getInfo();
        addButton.classList.add('--updated');
      });

      return section;
    });

    return productBuySections;
  };

  this.validateNumber = (numberInput, numberInputValue, productID) => {
    const currentProduct = this.getProductItemByID(productID);
    const { availableAmount, unit, unitSellby } = this.getProductItemByID(productID);

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
    const numberInput = wrapper.querySelector('.product_buy__number');
    const numberDown = wrapper.querySelector('.product_buy__number_down');
    const numberUp = wrapper.querySelector('.product_buy__number_up');

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
