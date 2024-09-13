/**
 * Slider bazujący na właściwości CSS scroll-snap
 * @param {*} selectors lista węzłów na których będzie inicjowany slider
 * @param {*} childrenClass klasa CSS pojedynczego slajdu (bezpośredni potomek selektora)
 */
function ScrollSnapSlider(selectors, childrenClass) {
  // Sprawdzenie czy aktywować slider
  this.hasScroll = (selector) => selector.scrollWidth > selector.clientWidth;

  // Usuwanie slidera
  this.destroy = (selector) => {
    const arrows = selector.querySelectorAll('.slick-arrow');
    if (arrows) arrows.forEach((arrow) => arrow.remove());

    const parent = selector.parentNode;
    const parentParent = parent.parentNode;

    if (!parent.classList.contains('scroll_snap_slider')) return;
    parentParent.append(selector);
    parentParent.insertBefore(selector, parent);
    parent.remove();
  };

  // Przygotowanie struktury dla slidera
  this.template = (selector) => {
    const container = document.createElement('div');
    const slickPrev = document.createElement('div');
    const slickNext = document.createElement('div');
    container.classList.add('scroll_snap_slider');
    slickPrev.classList.add('slick-arrow', 'slick-prev');
    slickNext.classList.add('slick-arrow', 'slick-next');

    container.appendChild(slickPrev);
    container.appendChild(slickNext);

    const parent = selector.parentNode;
    parent.insertBefore(container, selector);
    container.appendChild(selector);
    const selectorClassList = selector.classList;
    selectorClassList.forEach((selectorClass) => container.classList.add(`--${selectorClass}`));

    if (!this.hasScroll(selector)) {
      slickPrev.classList.add('d-none');
      slickNext.classList.add('d-none');
    }

    return {
      container, slickPrev, slickNext,
    };
  };

  // Observer dla selectorów
  this.iObserver = new IntersectionObserver((selector, slickPrev, slickNext) => {
    if (selector.isIntersecting) {
      if (this.hasScroll(selector)) {
        slickPrev.classList.add('d-block');
        slickNext.classList.add('d-block');
        slickPrev.classList.remove('d-none');
        slickNext.classList.remove('d-none');
      } else {
        slickPrev.classList.remove('d-block');
        slickNext.classList.remove('d-block');
        slickPrev.classList.add('d-none');
        slickNext.classList.add('d-none');
      }
    }
  });

  this.events = {
    prev: (selector, slickPrev) => {
      slickPrev.addEventListener('click', () => {
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
        const itemSize = selector.querySelector(childrenClass).clientWidth;
        selector.scrollBy({
          behavior: 'smooth',
          left: -itemSize + 10,
          top: 0,
        });
        const { scrollLeft, scrollWidth } = selector;
        if (scrollLeft === 0) {
          selector.scrollBy({
            behavior: 'smooth',
            left: scrollWidth,
            top: 0,
          });
        }
      });
    },
    next: (selector, slickNext) => {
      slickNext.addEventListener('click', () => {
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
        const itemSize = selector.querySelector(childrenClass).clientWidth;
        selector.scrollBy({
          behavior: 'smooth',
          left: itemSize - 10,
          top: 0,
        });
        const { offsetWidth, scrollLeft, scrollWidth } = selector;
        if (offsetWidth + scrollLeft >= scrollWidth) {
          selector.scrollBy({
            behavior: 'smooth',
            left: -scrollWidth,
            top: 0,
          });
        }
      });
    },
    scroll: (selector) => {
      selector.addEventListener('scroll', () => {
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
      });
    },
  };

  // Kompilacja wszsytkich metod do tworzenia sliderów
  this.create = () => {
    selectors.forEach((selector) => {
      if (!this.hasScroll(selector)) return false;

      this.destroy(selector);

      const template = this.template(selector);
      const { slickPrev, slickNext } = template;

      this.iObserver.observe(selector, slickPrev, slickNext);
      this.events.prev(selector, slickPrev);
      this.events.next(selector, slickNext);
      this.events.scroll(selector);
      return true;
    });
  };

  this.init = () => {
    this.create();
  };
}
