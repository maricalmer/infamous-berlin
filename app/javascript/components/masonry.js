import Masonry from 'masonry-layout';



// function markLoadedImgs(event) {
//   event.currentTarget.myParam = 1;
//   checkOnImgsState();
// }
// function checkOnImgsState() {
//   const imgs = document.querySelectorAll(".card-img-js");
//   imgs.forEach((img) => {
//     if (img.complete) {
//       img.myParam = 1;
//     } else {
//       img.addEventListener("load", checkOnImgsState);
//       // img.addEventListener("error", markLoadedImgs);
//       // ^^ rspec
//     };
//   });
//   let counter = 0;
//   imgs.forEach((img) => {
//     counter = counter + img.myParam
//   });
//   if (counter == imgs.length) {
//     setTimeout(function(){
//       setSize();
//     }, 100);
//   };
// };



let counter = 0;

function setSize() {
  counter = 0
  const elem = document.querySelector('.masonry-grid-js');
  organiseResults(elem, 50);
}

const setWrapperMinHeight = (img, pic, amountPics) => {
  const ratio = img.width / img.height
  pic.parentElement.style.minHeight = `${192 / ratio}px`
  ++counter
  if (counter == amountPics) {
    setTimeout(function(){
      setSize();
    }, 150);
  }
}


const setMinHeightOnWrapper = () => {
  const pics = document.querySelectorAll(".masonry-pic-js")
  pics.forEach((pic) => {
    const img = new Image()
    if (pic.tagName == "IMG") {
      img.src = pic.src
    } else {
      img.src = pic.poster
    }
    if (img.complete) {
      setWrapperMinHeight(img, pic, pics.length)
    } else {
      img.addEventListener('load', setWrapperMinHeight(img, pic, pics.length))
    }
  })
}

function organiseResults(elem, gutter) {
  let msnry = new Masonry( elem, {
    itemSelector: '.masonry-item-js',
    gutter: gutter,
    horizontalOrder: true,
    transitionDuration: 0
  });
  msnry.layout()
}

// const loadGalleryOnTabClick = () => {
//   const tab = document.getElementById("projectTab");
//   if (tab) {
//     tab.addEventListener("click", checkOnImgsState)
//   }
// }

const loadGallery = () => {
  // checkOnImgsState();
  setMinHeightOnWrapper();
}

export { loadGallery };
