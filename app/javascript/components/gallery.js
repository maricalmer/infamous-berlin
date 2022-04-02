import Masonry from 'masonry-layout';

function setSize() {
  const upcomingProject = document.querySelector(".upcoming-projects-style-js")
  if (upcomingProject) {
    const elem = document.querySelector('.grid-search');
    organiseResults(elem, 50);
  }
  const portfolio = document.querySelector(".portfolio-style-js")
  if (portfolio) {
    const elem = document.querySelector('.big-grid-search');
    organiseResults(elem, 20);
  }
}

function markLoadedImgs(event) {
  event.currentTarget.myParam = 1;
  checkOnImgsState();
}

function checkOnImgsState() {
  const imgs = document.querySelectorAll(".card-img");
  if (imgs.length > 0) {
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
      setSize()
    };
  }
};

function organiseResults(elem, gutter) {
  let msnry = new Masonry( elem, {
    itemSelector: '.grid-search-item',
    gutter: gutter,
    horizontalOrder: true,
    transitionDuration: 0,
    // fitWidth: true,
    percentPosition: true
  });
}

const loadGalleryOnTabClick = () => {
  const tab = document.getElementById("projectTab");
  if (tab) {
    tab.addEventListener("click", checkOnImgsState)
  }
}

const loadGallery = () => {
  checkOnImgsState();
}

export { loadGalleryOnTabClick, loadGallery };
