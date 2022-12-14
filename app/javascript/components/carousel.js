import { playFileOnClick } from '../components/play_audio_file';

const scrollUp = () => {
  const thumbnailsContainer = document.querySelector(".thumbnails-js");
  thumbnailsContainer.scroll({top: 0, behavior: 'smooth'});
};

const scrollDown = () => {
  const thumbnailsContainer = document.querySelector(".thumbnails-js");
  thumbnailsContainer.scroll({top: thumbnailsContainer.scrollHeight, behavior: 'smooth'});
};

const scrollOnArrows = () => {
  const arrowUp = document.querySelector(".arrow-up-js");
  const arrowDown = document.querySelector(".arrow-down-js");
  arrowUp.addEventListener("click", scrollUp);
  arrowDown.addEventListener("click", scrollDown);
}

const hideArrowsDependingOnScrollType = (event) => {
  if (event.target.scrollTop == 0) {
    const arrowUp = document.querySelector(".arrow-up-js");
    arrowUp.classList.add("carousel__arrow--hidden");
  } else if (event.target.offsetHeight + event.target.scrollTop >= event.target.scrollHeight - 19) {
    const arrowDown = document.querySelector(".arrow-down-js");
    arrowDown.classList.add("carousel__arrow--hidden");
  } else {
    const arrowUp = document.querySelector(".arrow-up-js");
    const arrowDown = document.querySelector(".arrow-down-js");
    arrowUp.classList.remove("carousel__arrow--hidden");
    arrowDown.classList.remove("carousel__arrow--hidden");
  };
};

const hideArrowsOnScroll = () => {
  const thumbnailsContainer = document.querySelector(".thumbnails-js");
  thumbnailsContainer.addEventListener("scroll", hideArrowsDependingOnScrollType);
};

const markLoadedImgs = (event) => {
  event.currentTarget.myParam = 1;
  checkOnFilesState();
}

const checkOnFilesState = () => {
  const files = document.querySelectorAll(".thumbnail-js");
  files.forEach((file) => {
    if (file.nodeName === "IMG") {
      if (file.complete) {
        file.myParam = 1;
      } else {
        file.addEventListener("load", checkOnFilesState);
        file.addEventListener("error", markLoadedImgs);
      };
    }
    else if (file.nodeName === "VIDEO") {
      if (file.readyState > 1) {
        file.myParam = 1;
      } else {
        file.addEventListener("loadeddata", checkOnFilesState);
        file.addEventListener("error", markLoadedImgs);
      };
    }
  });
  let counter = 0;
  files.forEach((file) => {
    counter = counter + file.myParam
  });
  if (counter == files.length) {
    downArrowOnLoad();
  };
};

const downArrowOnLoad = () => {
  const thumbnails = document.querySelector(".thumbnails-js");
  if (thumbnails.scrollHeight > thumbnails.clientHeight) {
    const arrowDown = document.querySelector(".arrow-down-js");
    arrowDown.classList.remove("carousel__arrow--hidden");
  };
  if (thumbnails.scrollTop > 0) {
    const arrowUp = document.querySelector(".arrow-up-js");
    arrowUp.classList.remove("carousel__arrow--hidden");
  };
};

const buildMainPosterDesktop = (event) => {
  const imgSlide = document.querySelector(".img-slide-js");
  const overlay = document.querySelector(".overlay-body-big-screen-js");
  if (event.currentTarget.src.includes("logo-audio")) {
    const link = event.currentTarget.nextElementSibling.firstElementChild.src.replace(".webm", "")
    const newElement = `<div class="carousel__main-audio-control-wrapper img-slide-js"><img class="carousel__main-audio-poster play-audio-js" src="/assets/logo-audio.png"><video class="carousel__main-audio-control" controls="controls" src="${link}.mp3"></video></div>`
    imgSlide.outerHTML = newElement
    playFileOnClick()
  } else if (event.currentTarget.nodeName === "IMG") {
    const newElement = `<picture class="carousel__img-video-wrapper img-slide-js" data-bs-toggle="modal" data-bs-target="#modalBigScreen"><source srcset="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=" media="(max-width: 992px)"><img class="carousel__main-img-poster" src=${event.currentTarget.src}></picture>`
    const img = `<img src="${event.currentTarget.src}">`
    imgSlide.outerHTML = newElement
    overlay.firstElementChild.outerHTML = img
  } else if (event.currentTarget.nodeName === "VIDEO") {
    const link = event.currentTarget.poster.replace(".jpg", "")
    const newElement = `<picture class="carousel__img-video-wrapper img-slide-js"><source class="carousel__main-poster" srcset="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=" media="(max-width: 992px)"><video class="carousel__main-video-poster" controls="controls" muted="muted" poster=${link.concat('.jpg')}><source src=${link.concat('.webm')} type="video/webm"><source src=${link.concat('.mp4')} type="video/mp4"><source src=${link.concat('.ogv')} type="video/ogg"></video></picture>`
    imgSlide.outerHTML = newElement
  }
  const thumbnailsImg = document.querySelectorAll(".thumbnail-js");
  thumbnailsImg.forEach((thumbnail) => { thumbnail.parentElement.classList.remove("carousel__thumbnail--big") });
  event.currentTarget.parentElement.classList.add("carousel__thumbnail--big");
};

const changeImgDesktop = () => {
  const thumbnailsImg = document.querySelectorAll(".thumbnail-js");
  thumbnailsImg.forEach((thumbnail) => {
    thumbnail.addEventListener("click", buildMainPosterDesktop);
  });
}

let i = 0;
const changeImgMobile = (event) => {
  const imgs = document.querySelectorAll(".thumbnail-js");
  const placeholderImg = document.querySelector(".placeholder-mobile-js");
  const correspondingFile = imgs[event.currentTarget.dataset.dotId]
  if (correspondingFile.src.includes("logo-audio")) {
    const link = correspondingFile.nextElementSibling.firstElementChild.src.replace(".webm", "")
    placeholderImg.firstElementChild.outerHTML = `<div class="carousel__mobile-audio-control-wrapper"><img class="carousel__audio-poster play-audio-js" src="/assets/logo-audio.png"><video controls="controls" class="carousel__audio-control" src="${link}.mp3"></video></div>`
    placeholderImg.removeAttribute('data-bs-toggle');
    placeholderImg.removeAttribute('data-bs-target');
    playFileOnClick()
  } else if (correspondingFile.nodeName === "IMG") {
    const imgModal = document.querySelector(".overlay-body-small-screen-js").firstElementChild;
    imgModal.src = correspondingFile.src;
    placeholderImg.firstElementChild.outerHTML = `<img class="carousel__mobile-img" src=${correspondingFile.src}>`
    placeholderImg.setAttribute('data-bs-toggle', 'modal');
    placeholderImg.setAttribute('data-bs-target', '#modalSmallScreen');
  } else if (correspondingFile.nodeName === "VIDEO") {
    const link = correspondingFile.poster.replace(".jpg", "")
    placeholderImg.firstElementChild.outerHTML = `<video class="carousel__mobile-video" controls="controls" poster=${link.concat('.jpg')}><source src=${link.concat('.webm')} type=\"video/webm\"><source src=${link.concat('.mp4')} type=\"video/mp4\"><source src=${link.concat('.ogv')} type=\"video/ogg\"></video>`
    placeholderImg.removeAttribute('data-bs-toggle');
    placeholderImg.removeAttribute('data-bs-target');
  }
  i = parseInt(event.currentTarget.dataset.dotId);
  const dots = document.querySelectorAll(".dot-js");
  dots.forEach((dot) => {
    dot.classList.remove("carousel__mobile-dot--active");
  });
  event.currentTarget.classList.add("carousel__mobile-dot--active");
};

const switchImgWithDots = () => {
  const dots = document.querySelectorAll(".dot-js");
  dots.forEach((dot) => {
    dot.addEventListener("click", changeImgMobile);
  });
}

let x0 = null;

const unify = (event) => {
  return event.changedTouches ? event.changedTouches[0] : event
};

const lock = (e) => {
  x0 = unify(e).clientX
};

const move = (e) => {
  const placeholderImg = document.querySelector(".placeholder-mobile-js");
  const imgs = document.querySelectorAll(".thumbnail-js");
  const imgModal = document.querySelector(".overlay-body-small-screen-js").firstElementChild;
  if(x0 || x0 === 0) {
    const dx = unify(e).clientX - x0, s = Math.sign(dx);
    if((i > 0 || s < 0) && (i < imgs.length - 1 || s > 0)) {
      if (imgs[i-s].nodeName === "IMG") {
        imgModal.src = imgs[i-s].src ;
        placeholderImg.firstElementChild.outerHTML = `<img class="carousel__mobile-img src=${imgs[i-s].src}>`
        placeholderImg.setAttribute('data-bs-toggle', 'modal');
        placeholderImg.setAttribute('data-bs-target', '#modalSmallScreen');
      } else if (imgs[i-s].poster.includes("logo-audio")) {
        const link = imgs[i-s].firstElementChild.src.replace(".webm", "")
        placeholderImg.firstElementChild.outerHTML = `<div class="carousel__mobile-audio-control-wrapper"><img class="carousel__audio-poster play-audio-js" src="/assets/logo-audio.png"><video controls="controls" class="carousel__audio-control" src="${link}.mp3"></video></div>`
        placeholderImg.removeAttribute('data-bs-toggle');
        placeholderImg.removeAttribute('data-bs-target');
      } else if (imgs[i-s].nodeName === "VIDEO") {
        const link = imgs[i-s].poster.replace(".jpg", "")
        placeholderImg.firstElementChild.outerHTML = `<video class="carousel__mobile-video" controls="controls" poster=${link.concat('.jpg')}><source src=${link.concat('.webm')} type=\"video/webm\"><source src=${link.concat('.mp4')} type=\"video/mp4\"><source src=${link.concat('.ogv')} type=\"video/ogg\"></video>`
        placeholderImg.removeAttribute('data-bs-toggle');
        placeholderImg.removeAttribute('data-bs-target');
      }
      const dots = document.querySelectorAll(".dot-js");
      dots.forEach((dot) => {
        dot.classList.remove("carousel__mobile-dot--active");
      });
      i -= s;
      dots[i].classList.add("carousel__mobile-dot--active");
    }
    x0 = null
  }
};

const switchImgWithSwipe = () => {
  const carousel = document.querySelector(".carousel-container-js");
  carousel.addEventListener("touchstart", lock);
  carousel.addEventListener("touchend", move);
}

export { scrollOnArrows, hideArrowsOnScroll, changeImgDesktop, checkOnFilesState, switchImgWithDots, switchImgWithSwipe };
