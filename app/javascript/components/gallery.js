import Masonry from 'masonry-layout';



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
      organiseResults();
    };
  }
};

function organiseResults() {
  var elem = document.querySelector('.grid-search');
  var msnry = new Masonry( elem, {
    itemSelector: '.grid-search-item',
    columnWidth: 200,
    gutter: 50,
    horizontalOrder: true,
    fitWidth: true,
    transitionDuration: 0
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
