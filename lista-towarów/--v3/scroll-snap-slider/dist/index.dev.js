"use strict";

/**
 * Slider bazujący na właściwości CSS scroll-snap
 * @param {*} selectors lista węzłów na których będzie inicjowany slider
 * @param {*} childrenClass klasa CSS pojedynczego slajdu (bezpośredni potomek selektora)
 */
function ScrollSnapSlider(selectors, childrenClass) {
  var _this = this;

  // Sprawdzenie czy aktywować slider
  this.hasScroll = function (selector) {
    return selector.scrollWidth > selector.clientWidth;
  }; // Usuwanie slidera


  this.destroy = function (selector) {
    var arrows = selector.querySelectorAll('.slick-arrow');
    if (arrows) arrows.forEach(function (arrow) {
      return arrow.remove();
    });
    var parent = selector.parentNode;
    var parentParent = parent.parentNode;
    if (!parent.classList.contains('scroll_snap_slider')) return;
    parentParent.append(selector);
    parentParent.insertBefore(selector, parent);
    parent.remove();
  }; // Przygotowanie struktury dla slidera


  this.template = function (selector) {
    var container = document.createElement('div');
    var slickPrev = document.createElement('div');
    var slickNext = document.createElement('div');
    container.classList.add('scroll_snap_slider');
    slickPrev.classList.add('slick-arrow', 'slick-prev');
    slickNext.classList.add('slick-arrow', 'slick-next');
    container.appendChild(slickPrev);
    container.appendChild(slickNext);
    var parent = selector.parentNode;
    parent.insertBefore(container, selector);
    container.appendChild(selector);
    var selectorClassList = selector.classList;
    selectorClassList.forEach(function (selectorClass) {
      return container.classList.add("--".concat(selectorClass));
    });

    if (!_this.hasScroll(selector)) {
      slickPrev.classList.add('d-none');
      slickNext.classList.add('d-none');
    }

    return {
      container: container,
      slickPrev: slickPrev,
      slickNext: slickNext
    };
  }; // Observer dla selectorów


  this.iObserver = new IntersectionObserver(function (selector, slickPrev, slickNext) {
    if (selector.isIntersecting) {
      if (_this.hasScroll(selector)) {
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
    prev: function prev(selector, slickPrev) {
      slickPrev.addEventListener('click', function () {
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
        var itemSize = selector.querySelector(childrenClass).clientWidth;
        selector.scrollBy({
          behavior: 'smooth',
          left: -itemSize + 10,
          top: 0
        });
        var scrollLeft = selector.scrollLeft,
            scrollWidth = selector.scrollWidth;

        if (scrollLeft === 0) {
          selector.scrollBy({
            behavior: 'smooth',
            left: scrollWidth,
            top: 0
          });
        }
      });
    },
    next: function next(selector, slickNext) {
      slickNext.addEventListener('click', function () {
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
        var itemSize = selector.querySelector(childrenClass).clientWidth;
        selector.scrollBy({
          behavior: 'smooth',
          left: itemSize - 10,
          top: 0
        });
        var offsetWidth = selector.offsetWidth,
            scrollLeft = selector.scrollLeft,
            scrollWidth = selector.scrollWidth;

        if (offsetWidth + scrollLeft >= scrollWidth) {
          selector.scrollBy({
            behavior: 'smooth',
            left: -scrollWidth,
            top: 0
          });
        }
      });
    },
    scroll: function scroll(selector) {
      selector.addEventListener('scroll', function () {
        if (app_shop.vars.bLazy) app_shop.vars.bLazy.revalidate();
      });
    }
  }; // Kompilacja wszsytkich metod do tworzenia sliderów

  this.create = function () {
    selectors.forEach(function (selector) {
      if (!_this.hasScroll(selector)) return false;

      _this.destroy(selector);

      var template = _this.template(selector);

      var slickPrev = template.slickPrev,
          slickNext = template.slickNext;

      _this.iObserver.observe(selector, slickPrev, slickNext);

      _this.events.prev(selector, slickPrev);

      _this.events.next(selector, slickNext);

      _this.events.scroll(selector);

      return true;
    });
  };

  this.init = function () {
    _this.create();
  };
}
//# sourceMappingURL=index.dev.js.map
