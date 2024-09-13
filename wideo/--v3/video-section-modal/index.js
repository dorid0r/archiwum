function VideoYtSection(param) {
  this.param = param || {};
  
  this.setAttribute = (el, attrs) => {
    for (const name in attrs) { 
      el.setAttribute(name, attrs[name]);
    };
  };
  
  this.setVideo = () => {
    this.videoBoxes.forEach((box) => {
      const videoImg = box.querySelector(this.videoFrame).src;
      this.setAttribute(box, { 'data-video-img': videoImg });
      const video = document.createElement('iframe');
      this.setAttribute(video, {
        src: box.dataset.videoId,
        frameBorder: '0',
        allow: 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share',
        allowfullscreen: '',
      });
      video.classList.add(this.videoFrameClass);
      this.activeVideoEvent(box, video);
    });
  };

  this.setImg = () => {
    this.videoBoxes.forEach((box) => {
      if (box.querySelector('iframe')) {
        const videoImg = document.createElement('img');
        this.setAttribute(videoImg, { src: box.dataset.videoImg, loading: 'lazy' });
        videoImg.classList.add(this.videoFrameClass, 'player');
        box.classList.remove(this.videoActiveClass);
        box.querySelector('iframe').replaceWith(videoImg);
      }
    });
  };

  this.activeVideoEvent = (box, videoIframe) => {
    box.querySelector(this.videoButton).addEventListener('click', () => {
      Modal({
        element: videoIframe,
        classList: 'yt_modal',
        bodyClassModal: '--video',
      });
    });
  };
  this.slider = () => {
    const count = document.querySelector(this.sliderSelector)?.dataset?.count;
    if (count && count < (this.minimalSlidesToRun)) return;
    if (this.sliderRuningViews.includes(Number(app_shop.vars.view))) {
      $(`${this.sliderSelector}:not(.slick-initialized)`).slick(this.settings);
      app_shop.vars.videoSlickRunning = true;
    } else if (app_shop.vars.videoSlickRunning) {
      $(`${this.sliderSelector}`).slick('unslick');
      app_shop.vars.videoSlickRunning = false;
    }
  };

  this.init = () => {
    const {
      videoBoxes,
      videoFrame,
      videoButton,
      videoFrameClass,
      videoActiveClass,
      sliderOptions,
      sliderRuningViews,
      sliderSelector,
      minimalSlidesToRun,
    } = this.param;

    this.videoBoxes = videoBoxes
      ? document.querySelectorAll(videoBoxes)
      : document.querySelectorAll('#video_button .video');

    this.videoFrame = videoFrame || '.video__frame';
    this.videoButton = videoButton || '.video__button';
    this.videoFrameClass = videoFrameClass || 'video__frame';
    this.videoActiveClass = videoActiveClass || '--activeVideo';
    this.sliderSelector = sliderSelector || '.video_button__list';
    this.sliderOptions = sliderOptions || false;
    this.sliderRuningViews = sliderRuningViews || [3, 4];
    this.minimalSlidesToRun = minimalSlidesToRun || 5;
    this.defaults = {
      prevArrow: '<a class="slick-prev" href=""><i class="icon-angle-left"></i></a>',
      nextArrow: '<a class="slick-next" href=""><i class="icon-angle-right"></i></a>',
      slidesToShow: 4,
      infinite: false,
    };
    this.settings = _objectSpread({}, this.defaults, {}, sliderOptions);
    this.setVideo();
  };
};

app_shop.fn.videoYtSection = new VideoYtSection();

app_shop.run(function videoYtSectionInit() {
  app_shop.fn.videoYtSection.init();;
}, 'all', '.video_button .video');

app_shop.run(function videoYtSectionSlick() {
  app_shop.fn.videoYtSection.slider();
}, [1, 2, 3, 4], '.video_button .video');
