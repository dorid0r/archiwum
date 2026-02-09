/**
 * 
 * @param {*} param obiekt z selektorami
 */

function VideoInSlider(param) {
  this.param = param || {};
  this.selector = this.param?.selector || '#main_banner1 video';
  this.selectorActiveSlide = this.param?.selectorActiveSlide || '#main_banner1 .slick-active video';
  this.playVideo = () => document.querySelector(this.selectorActiveSlide)?.play();
  this.pauseVideo = () => document.querySelector(this.selectorActiveSlide)?.pause();
  this.pauseAllVideo = () => {
    document.querySelectorAll(this.selector).forEach((v) => v.pause());
  };
  this.init = () => {
    document.querySelectorAll(this.selector).forEach((video) => {
      video.muted = true;
      video.loop = true;
      video.removeAttribute('controls');
    });
  };
}

// wywołanie
app_shop.run(function banery() {
  app_shop.fn.sliderVideo = new VideoInSlider();
  app_shop.fn.sliderVideo.init();
}, 'all', '#main_banner1');

// podpięcie pod głowny slider
app_shop.fn.mainSlider = new MainSlider({
  selector: '.main_slider:not(.slick-initialized)',
  callbackAfter: () => {
    app_shop.fn.sliderVideo.playVideo();
  },
  callbackBefore: (slider) => {
    slider.on('afterChange', () => {
      // Załadowanie zdjęcia
      if (document.querySelector('#main_banner1 .slick-active img:not(.b-loaded)')) app_shop.vars.bLazy.revalidate();
      app_shop.fn.sliderVideo.playVideo();
    });
    slider.on('beforeChange', () => {
      app_shop.fn.sliderVideo.pauseVideo();
    });
  },
});
