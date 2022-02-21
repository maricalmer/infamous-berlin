function xScrollLeft(event) {
  const slider = event.target.parentNode.nextElementSibling;
  slider.scrollBy({left:-200, behavior: 'smooth'});
};
function xScrollRight(event) {
  const slider = event.target.parentNode.previousElementSibling;
  slider.scrollBy({left:200, behavior: 'smooth'});
};
const xScrollOnArrows = () => {
  const arrowsLeft = document.querySelectorAll(".past-chevron-left");
  const arrowsRight = document.querySelectorAll(".past-chevron-right");
  arrowsLeft.forEach((arrow)=>{
    arrow.addEventListener("click", xScrollLeft)
  })
  arrowsRight.forEach((arrow)=>{
    arrow.addEventListener("click", xScrollRight)
  })
}

function hideArrowsDependingOnXScrollType(event) {
  if (event.target.scrollLeft == 0) {
    const arrowLeft = event.target.previousElementSibling.firstElementChild;
    arrowLeft.classList.add("chevron-hidden");
  } else if (event.target.offsetWidth + event.target.scrollLeft >= event.target.scrollWidth) {
    const arrowRight = event.target.nextElementSibling.firstElementChild;
    arrowRight.classList.add("chevron-hidden");
  } else {
    const arrowLeft = event.target.previousElementSibling.firstElementChild;
    const arrowRight = event.target.nextElementSibling.firstElementChild;
    arrowLeft.classList.remove("chevron-hidden");
    arrowRight.classList.remove("chevron-hidden");
  };
};

const hideArrowsOnXScroll = () => {
  const sliders = document.querySelectorAll(".js-slider");
  sliders.forEach((slider)=>{
    slider.addEventListener("scroll", hideArrowsDependingOnXScrollType)
  })
};

function markLoadedImgs(event) {
  event.currentTarget.myParam = 1;
  checkOnDashImgsState();
}

function checkOnDashImgsState() {
  const imgs = document.querySelectorAll(".portfolio-part img");
  imgs.forEach((img) => {
    if (img.complete) {
      img.myParam = 1;
    } else {
      img.addEventListener("load", checkOnDashImgsState);
      img.addEventListener("error", markLoadedImgs);
      // ^^ rspec
    };
  });
  let counter = 0;
  imgs.forEach((img) => {
    counter = counter + img.myParam
  });
  if (counter == imgs.length) {
    hideLeftArrowOnLoad();
  };
};

const hideLeftArrowOnLoad = () => {
  const projectCardSliders = document.querySelectorAll(".dash-cards-slider");
  projectCardSliders.forEach((projectCards) => {
    if (projectCards.scrollWidth > projectCards.clientWidth) {
      const arrowRight = projectCards.nextElementSibling.firstElementChild;
      arrowRight.classList.remove("chevron-hidden");
    } else if (projectCards.scrollLeft > 0) {
      console.log(projectCards.scrollLeft)
      const arrowLeft = projectCards.previousElementSibling.firstElementChild;
      arrowLeft.classList.remove("chevron-hidden");
    } else {
      const arrowRight = projectCards.nextElementSibling.firstElementChild;
      const arrowLeft = projectCards.previousElementSibling.firstElementChild;
      arrowRight.classList.add("chevron-hidden");
      arrowLeft.classList.add("chevron-hidden");
    };
  });
};

export { xScrollOnArrows, hideArrowsOnXScroll, checkOnDashImgsState };
