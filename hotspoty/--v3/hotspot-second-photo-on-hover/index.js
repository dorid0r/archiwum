/**
 * 
 * @param {*} nodesList lista elementów na której szukamy .product
 */
function SecondPhotoHover(nodesList) {
  this.events = {
    mouseenter: (product) => {
      product.addEventListener('mouseenter', () => {
        if (app_shop.vars.view < 3) return;
        product.classList.add('--hovering');
        this.swapPhoto(product);
      });
    },
    mouseleave: (product) => {
      product.addEventListener('mouseleave', () => {
        if (app_shop.vars.view < 3) return;
        product.classList.remove('--hovering');
        this.swapPhoto(product);
      });
    },
  };
  // podmiana ścieżki dla picture/source
  this.swapWebpSource = (sourcesWEBP, link) => {
    if (sourcesWEBP.length > 0) {
      sourcesWEBP.forEach((sourceWebp) => {
        sourceWebp.srcset = link;
      });
    }
  };
  // podmiana ścieżki zdjęcia
  this.swapPhoto = (product) => {
    const icon = product.querySelector('.product__icon');
    if (!icon.dataset.second_src) return;
    const img = icon.querySelector('img');
    const sourcesWEBP = icon.querySelectorAll('picture source[type="image/webp"]');
    if (product.classList.contains('--hovering')) {
      img.src = icon.dataset.second_src;
      this.swapWebpSource(sourcesWEBP, icon.dataset.second_src);
    } else {
      img.src = icon.dataset.first_src;
      this.swapWebpSource(sourcesWEBP, icon.dataset.first_src);
    }
  };
  // dodanie eventów dla każdego produktu
  this.addActions = (array) => {
    array.forEach((product) => {
      this.events.mouseenter(product);
      this.events.mouseleave(product);
    });
  };
  this.init = () => {
    if (!nodesList) return;
    nodesList.forEach((zone) => {
      this.addActions(zone.querySelectorAll('.product'));
    });
  };
}

// wywołanie w app_shop.fn.hotspotAjaxInit w afterAllHotspotsCallback
const hotspotSecondPhoto = new SecondPhotoHover(document.querySelectorAll('.hotspot'));
hotspotSecondPhoto.init();
