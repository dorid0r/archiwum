app_shop.txt["txt_see_more"] = <iai:variable vid="Zobacz więcej" />;

app_shop.fn.initTabsHotspot = (selector) => {

  const hotspots = document.querySelectorAll(selector);
  const hotspotTabs = document.querySelector('#hotspot__tabs');
  const hotspotList = document.querySelectorAll('.hotspot');
  const getHotspotTabsHeadline = () => document.querySelectorAll('.hotspot__tabs .headline');
  const getHotspotTab = () => document.querySelector('#hotspot__tabs');
  let scrollTimer;

  function events(e) {
    e.preventDefault();
  
    if (this.classList.contains('active')) return;

    const id = this.getAttribute('data-id')?.replace('#', '');
    this.classList.add('active');
  
    [...this.parentNode.children].forEach((sibling) => {
      if (sibling !== this) {
        sibling.classList.remove('active');
      }
    });
  
    hotspotList.forEach((innerElem) => {
      if (innerElem.id === id) {
        innerElem.classList.add('active');
      } else {
        innerElem.classList.remove('active');
      }
    });

    $('.products.slick-slider').slick('refresh');
    app_shop.vars?.bLazy.revalidate();
  }
  
  function initEvents(tabList) {
    const headlineElements = document.querySelectorAll('#hotspot__tabs .headline');
    tabList.forEach((el) => {
      el.addEventListener('click', events);
    });
    if (headlineElements.length > 0) {
      events.call(headlineElements[0], new Event('click'));
    }
  }

  if (!hotspots.length) return;
  if (hotspotTabs) {
    hotspotTabs.innerHTML = '';
  }

  const newHtml = [...hotspots].reduce((accumulator, el) => {
    const id = `#${el.getAttribute('id')}`;
    const name = el.querySelector('.headline__name')?.textContent || '';
    const headline = el.querySelector('.headline');
    const href = headline?.getAttribute('href') !== '' ? headline.getAttribute('href') : '';
    const html = `<div class="headline" data-id="${id}" data-href="${href}">${name}</div>`;
    return accumulator + html;
  }, '');

  hotspots[0].insertAdjacentHTML('beforebegin', '<div id="hotspot__tabs" class="hotspot__tabs"/>');
  const tab = getHotspotTab();
  if (tab) {
    tab.innerHTML = newHtml;
    tab.setAttribute('id', 'hotspot__tabs');
  }

  const tabList = getHotspotTabsHeadline();
  initEvents(tabList);

  // revalidate przy scrollu
  hotspotList.forEach((hotspot) => {
    const productElement = hotspot.querySelector('.products');
    productElement?.addEventListener('scroll', () => {
      if (scrollTimer) {
        clearTimeout(scrollTimer);
      }
      scrollTimer = setTimeout(function() {
        app_shop.vars?.bLazy && app_shop.vars.bLazy.revalidate();
      }, 100);
    });

    // Dodanie przycisku zobacz więcej, jeżeli h2 ma link
    const hotspotHeadline = hotspot.querySelector('h2 .headline');
    if (!hotspot.querySelector('.more') && hotspotHeadline?.getAttribute('href') !== undefined) {
      const moreHref = hotspotHeadline.getAttribute('href');
      const moreHTML = `<div class="more">
        <a class="btn --medium --outline more_link" href="${moreHref}">${app_shop.txt['txt_see_more']}</a>
      </div>`;
      hotspot.insertAdjacentHTML('beforeend', moreHTML);
    }
  });
};

// Zakładki dla Hotspotów mobile (rozwijane)
app_shop.fn.tabsMobileHS = (selector) => {
  const headlines = document.querySelectorAll(selector);
  headlines.forEach((element) => {
    element.addEventListener('click', (e) => {
      e.preventDefault();
      element.parentElement.classList.toggle('active');
        $('.products.slick-slider').slick('refresh');
      app_shop.vars?.bLazy.revalidate();
    });
  });
};
