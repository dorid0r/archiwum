const HotStuffBuilder = function HotStuffBuilder(param) {
    this.param = param || {};

    /*
    *  inicjacja licznika czasu do zakończenia promocji
    */
  
    this.countDownInit = () => {
      const promotionTillDate = this.productBox.dataset.date;
      const promotionTillHour = this.productBox.dataset.hour;
      if (promotionTillDate) {
        this.productBox.querySelector(`${this.timerClass}`).innerHTML = `<div id="CDT_${this.timerIDSufix}" class="product_section CDT-uniw"></div>`;
        const countDownDate = (promotionTillHour)
          ? new Date(`${promotionTillDate}T${promotionTillHour}`)
          : new Date(`${promotionTillDate}T23:59:59`);
        app_shop.vars[`timer_${this.timerIDSufix}`] = new CountdownTimer($(`#CDT_${this.timerIDSufix}`), countDownDate);
        app_shop.vars[`timer_${this.timerIDSufix}`].countDown();
      }
    };
  
    this.timerStrip = () => {
      const timerStrip = this.productBox.querySelector(`${this.timerStripClass}`);
      const { amount } = timerStrip.dataset;
      const { initAmount } = timerStrip.dataset;
      const ratio = amount / initAmount;
  
      timerStrip.querySelector(`${this.timerStripFillClass}`).style.width = `${ratio * 100}%`;
    };

    /*
    *  Ajaxowe pobieranie info o stanie magazynowym produktu i czasie trwania promocji.
    *  dlaczego tak? ponieważ w ten sposób najszybciej dostawałem aktualne info o ilościu produktu na stanie
    */
  
    
    this.getData = async () => {
      const productID = this.productBox.getAttribute('data-product-id');
  
      const searchResultQuery = `/ajax/projector.php?action=get&product=${productID}&get=sizes,sizeprices`;
  
      try {
        const response = await fetch(searchResultQuery, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json',
          },
          body: searchResultQuery,
        });
  
        const json = await response.json();
        const dataJson = json;
  
        this.productData = dataJson;
        return dataJson;
      } catch (error) {
        console.error('AJAX fetchDataProductsResults() Error:', error);
        return false;
      }
    };

    /*
    *  aktualizacja liczby dostępnych produktów
    */
    
    this.changeAmountInfo = () => {
       const timerBox = this.productBox.querySelector('.product_timer_strip');
       const timerAmount = timerBox.querySelector('#pts_curr');
       
       timerBox.setAttribute('data-amount', this.productData.sizes.amount);
       timerAmount.textContent = this.productData.sizes.amount;
    };

    /*
    *  dodanie do produktu atrybutów z datą i godziną zakończenia promocji
    */

    this.setTillDateAttribute = (sizeprices, promoType) => {
      if(sizeprices?.[`${promoType}tilldate`]) {
        this.productBox.setAttribute('data-date', sizeprices?.[`${promoType}tilldate`]);
        if (sizeprices?.[`${promoType}tillhour`]) this.productBox.setAttribute('data-hour', sizeprices?.[`${promoType}tillhour`]);
      }
    }
    
    this.setPromotionTime = () => {
      const {sizeprices} = this.productData;
      this.setTillDateAttribute(sizeprices, 'special');
      this.setTillDateAttribute(sizeprices, 'promotion');
      this.setTillDateAttribute(sizeprices, 'discount');
    };
  
    this.init = async () => {
      const {
        timerIDSufix,
        hotspotZone,
        productBox,
        timerClass,
        timerStripClass,
        timerStripFillClass,
        productData,
      } = this.param;
          
      this.timerIDSufix = timerIDSufix || 'zone1';
      this.hotspotZone = hotspotZone || '#menu_hotspot_zone1';
      this.timerClass = timerClass || '#productTimer';
      this.timerStripClass = timerStripClass || '.product_timer_strip';
      this.timerStripFillClass = timerStripFillClass || '.ptsr_value_fill';
  
      this.productBox = productBox
        ? document.querySelector(productBox)
        : document.querySelector(`${this.hotspotZone} .product`);
        
      this.productData = productData || await this.getData();
  
      this.changeAmountInfo();
      this.setPromotionTime();
      this.countDownInit();
      this.timerStrip();
    };
  };
  
  app_shop.run(function hotstuff1() {
    /*
    *  hotspotZone - Selector hotspotu
    *  timerIDSufix - sufix dla nazwy licznika czasu promocji (unikalny dla każdej promocji gdyby na stronie było więcej takich hotspotów)
    */
    app_shop.fn.hotStuffBuilderZone1 = new HotStuffBuilder({
      hotspotZone: '#menu_hotspot_zone1',
      timerIDSufix: 'zone1',
    });
  }, 'all', '#menu_hotspot_zone1 .product');