function scrollUp() {
  const thumbnailsImg = document.querySelectorAll(".thumbnail-js");
  thumbnailsImg[1].scrollIntoView({behavior: "smooth", block: "end"});
};

function scrollDown() {
  const thumbnailsImg = document.querySelectorAll(".thumbnail-js");
  thumbnailsImg[thumbnailsImg.length - 1].scrollIntoView({behavior: "smooth", block: "end"});
};

const scrollOnArrows = () => {
  const arrowUp = document.querySelector(".arrow-up");
  const arrowDown = document.querySelector(".arrow-down");
  arrowUp.addEventListener("click", scrollUp);
  arrowDown.addEventListener("click", scrollDown);
}

function hideArrowsDependingOnScrollType(event) {
  if (event.target.scrollTop == 0) {
    const arrowUp = document.querySelector(".arrow-up");
    arrowUp.classList.add("arrow-hidden");
  } else if (event.target.offsetHeight + event.target.scrollTop >= event.target.scrollHeight - 19) {
    const arrowDown = document.querySelector(".arrow-down");
    arrowDown.classList.add("arrow-hidden");
  } else {
    const arrowUp = document.querySelector(".arrow-up");
    const arrowDown = document.querySelector(".arrow-down");
    arrowUp.classList.remove("arrow-hidden");
    arrowDown.classList.remove("arrow-hidden");
  };
};

function markLoadedImgs(event) {
  event.currentTarget.myParam = 1;
  checkOnImgsState();
}

function checkOnImgsState() {
  const imgs = document.querySelectorAll(".thumbnail-js");
  imgs.forEach((img) => {
    if (img.complete) {
      img.myParam = 1;
    } else {
      img.addEventListener("load", checkOnImgsState);
      img.addEventListener("error", markLoadedImgs);
      // ^^ rspec
    };
  });
  let counter = 0;
  imgs.forEach((img) => {
    counter = counter + img.myParam
  });
  if (counter == imgs.length) {
    hideDownArrowOnLoad();
  };
};

const hideDownArrowOnLoad = () => {
  const thumbnails = document.querySelector(".thumbnails");
  if (thumbnails.scrollHeight > thumbnails.clientHeight) {
    const arrowDown = document.querySelector(".arrow-down");
    arrowDown.classList.remove("arrow-hidden");
  };
  if (thumbnails.scrollTop > 0) {
    const arrowUp = document.querySelector(".arrow-up");
    arrowUp.classList.remove("arrow-hidden");
  };
};

const hideArrowsOnScroll = () => {
  const thumbnails = document.querySelector(".thumbnails");
  thumbnails.addEventListener("scroll", hideArrowsDependingOnScrollType);
};

function grabImg(event) {
  const imgSlide = document.querySelector(".img-slide-big");
  const thumbnailsImg = document.querySelectorAll(".thumbnail-js");
  const overlay = document.querySelector(".overlay-body");
  if (event.target.nodeName === "IMG") {
    const newHTML = `<img src=${event.target.src}>`
    imgSlide.lastElementChild.outerHTML = newHTML
    overlay.firstChild.nextElementSibling.outerHTML = newHTML
    imgSlide.setAttribute('data-bs-toggle', 'modal');
    imgSlide.setAttribute('data-bs-target', '#modalBigScreen');
  } else if (event.target.nodeName === "VIDEO") {
    const link = event.target.poster.replace(".jpg", "")
    const newHTML = `<video controls="controls" poster=${link.concat('.jpg')}><source src=${link.concat('.webm')} type=\"video/webm\"><source src=${link.concat('.mp4')} type=\"video/mp4\"><source src=${link.concat('.ogv')} type=\"video/ogg\"></video>`
    imgSlide.lastElementChild.outerHTML = newHTML
    overlay.firstChild.nextElementSibling.outerHTML = newHTML
    imgSlide.removeAttribute('data-bs-toggle');
    imgSlide.removeAttribute('data-bs-target');
  }
  // overlay.firstChild.nextElementSibling.src = event.target.src;
  thumbnailsImg.forEach((thumbnail) => { thumbnail.parentElement.classList.remove("thumbnail-bigger") });
  event.target.parentElement.classList.add("thumbnail-bigger");
};

const changeImgDesktop = () => {
  const thumbnailsImg = document.querySelectorAll(".thumbnail-js");
  thumbnailsImg.forEach((thumbnail) => {
    thumbnail.addEventListener("click", grabImg);
  });
}

var i = 0;
function changeImgMobile(event) {
  var imgs = document.querySelectorAll(".slide-mobile");
  var placeholderImg = document.querySelector(".placeholder-mobile").firstElementChild;
  var imgModal = document.querySelector(".overlay-small-body").firstElementChild;
  placeholderImg.src = imgs[event.currentTarget.dataset.dotId].nextElementSibling.src;
  imgModal.src = imgs[event.currentTarget.dataset.dotId].nextElementSibling.src;
  i = parseInt(event.currentTarget.dataset.dotId);
  var dots = document.querySelectorAll(".dot");
  dots.forEach((dot) => {
    dot.classList.remove("dot-active");
  });
  event.currentTarget.classList.add("dot-active");
};
const switchImgWithDots = () => {
  var dots = document.querySelectorAll(".dot");
  dots.forEach((dot) => {
    dot.addEventListener("click", changeImgMobile);
  });
}

var x0 = null;
function unify(event) {return event.changedTouches ? event.changedTouches[0] : event};
function lock(e) {
  x0 = unify(e).clientX;
};
function move(e) {
  var imgPlaceholder = document.querySelector(".placeholder-mobile").firstElementChild;
  var imgModal = document.querySelector(".overlay-small-body").firstElementChild;
  var imgs = document.querySelectorAll(".slide-mobile");
  if(x0 || x0 === 0) {
    let dx = unify(e).clientX - x0, s = Math.sign(dx);

    if((i > 0 || s < 0) && (i < imgs.length - 1 || s > 0)) {
      imgPlaceholder.src = imgs[i-s].nextElementSibling.src || src1;
      imgModal.src = imgs[i-s].nextElementSibling.src || src1;
      var dots = document.querySelectorAll(".dot");
      dots.forEach((dot) => {
        dot.classList.remove("dot-active");
      });
      i -= s;
      dots[i].classList.add("dot-active");
    }
    x0 = null
  }
};
const switchImgWithSwipe = () => {
  var carousel = document.querySelector(".carousel-container");
  carousel.addEventListener("mousedown", lock);
  carousel.addEventListener("touchstart", lock);
  carousel.addEventListener("mouseup", move);
  carousel.addEventListener("touchend", move);
}

export { scrollOnArrows, hideArrowsOnScroll, changeImgDesktop, checkOnImgsState, switchImgWithDots, switchImgWithSwipe };
