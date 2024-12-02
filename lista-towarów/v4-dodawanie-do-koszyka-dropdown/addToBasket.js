class ProductListAddToBasketPlugin extends HotspotAddToBasketPlugin {
	constructor(params) {
		super(params);
		this.selector = params.selector || '#search';
		this.productsArray = [];
	}

	init() {
		this.productListElement = document.querySelector(this.selector);
		if (!this.productListElement) return;

		this.products = this.getProducts();
		this.productsArray.push(...this.products);

		this.setForms();
		this.setDropdown();
		this.setEvents();
	}


    getProducts() {
        const inputs = this.productListElement.querySelectorAll(`.product:not(.${this.prefix}) .add_to_basket input[name="product"]`);
            
        const result = [];
        for (const input of inputs) {
              const {id, size, availability, amount, sellby, singular, plural, unitPrecision } = input.dataset;
              result.push({
                          id,
                          type: 'product',
                          sizes: [{
                              size,
                              availability: { status: availability },
                              amount: parseFloat(amount),
                          }],
                          unit: {
                              sellBy: parseFloat(sellby),
                              singular: singular,
                              plural: plural,
                              precision: parseInt(unitPrecision),
                          },
                      });
            }
        return result;
    }

	setForms() {
		this.forms = this.products.map(productData => this.setForm(productData));
	}

	setForm(productData) {
		if (!productData) return false;
		this.activeProductData = productData;

		const product = this.productListElement.querySelector(`.product[data-product_id="${productData.id}"]`);
		if (!product) return false;
		this.activeTemplate = product.querySelector('.add_to_basket');
		if (!this.activeTemplate) return false;

		this.setformValues();

		product.classList?.add(this.prefix);
		return { productData, formElement: this.activeTemplate };
	}

	changeQuantitySearch(input) {
		if (!input || input.value === '') return false;
		const productId = input.dataset.id;
		input.value = this.validateNumber(parseFloat(input.value), productId);
	}

	validateNumber(quantity, productId) {
		const productData = this.productsArray.find(el => el?.id === productId);
		if (typeof quantity !== 'number' || !productData) return 1;

		const { plural, singular, sellBy, precision } = productData?.unit;
		const amount = productData.sizes?.[0]?.amount || -1;

		return this.numberCheck(
			{
				quantity,
				plural,
				singular,
				sellBy,
				precision,
				amount,
			},
			this.txt
		);
	}

	setDropdown() {
		this.numberBySelect = new NumberBySelect({
			selectClass: `${this.selector} .add_to_basket__number:not(.f-dropdown)`,
			inputClass: `${this.selector} .add_to_basket__more_input`,
			wrapperClass: `${this.selector} .add_to_basket__number_wrapper`,
			afterChangeValue: this.changeQuantitySearch.bind(this),
			hotspotElement: this.productListElement,
		});
	}

	setEvents() {
		this.forms.forEach(({ formElement }) => {
			const button = formElement?.querySelector('.add_to_basket__button');
			if (button) {
				button.addEventListener('click', e => {
					e.preventDefault();
					const form = e.target.closest('form');
					if (!form) return false;
					this.addToBasket(new FormData(form), e.target.closest('button') || e.target);
				});
			}
		});
	}
}
