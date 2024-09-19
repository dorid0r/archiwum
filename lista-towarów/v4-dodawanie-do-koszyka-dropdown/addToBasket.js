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
		const productElements = [...this.productListElement.querySelectorAll(`.product:not(.${this.prefix})`)];
		return productElements
			.map(productElement => {
				const id = productElement.dataset.product_id;
				const form = productElement.querySelector('.add_to_basket');
				if (!form) return null;

				const sizeInput = form.querySelector('input[name="size"]');
				const size = sizeInput ? sizeInput.value : 'uniw';
				const inputData = form.querySelector('input[name="product"]');

				const sellBy = parseFloat(inputData.dataset.sellby);
				const unit = inputData.dataset.unit;
				const singular = inputData.dataset.singular;
				const plural = inputData.dataset.plural;
				const precision = parseInt(inputData.dataset.unitPrecision);
				const amount = parseFloat(inputData.dataset.amount);

				const productData = {
					id,
					sizes: [
						{
							size,
							availability: { status: 'available' },
							amount,
						},
					],
					unit: {
						sellBy,
						singular,
						plural,
						precision,
					},
					link: productElement.querySelector('a')?.getAttribute('href') || '',
					type: 'product',
				};

				return productData;
			})
			.filter(Boolean);
	}

	setForms() {
		this.forms = this.products.map(productData => this.setForm(productData));
	}

	setForm(productData) {
		if (!productData) return false;
		this.activeProductData = productData;

		const productElement = this.productListElement.querySelector(`.product[data-product_id="${productData.id}"]`);
		if (!productElement) return false;
		this.activeTemplate = productElement.querySelector('.add_to_basket');
		if (!this.activeTemplate) return false;

		this.setformValues();

		productElement.classList?.add(this.prefix);
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
				button.addEventListener('click', async e => {
					e.preventDefault();
					const form = e.target.closest('form');
					if (!form) return false;
					await this.addToBasket(new FormData(form), e.target.closest('button') || e.target);
				});
			}
		});
	}
}
