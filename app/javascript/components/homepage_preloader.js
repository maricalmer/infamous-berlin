const hideLoader = () => {
  document.body.style.overflow = "hidden"
  const textCover = document.querySelector(".preloader-text-cover-js")
  const preloader = document.querySelector(".preloader-js")
  textCover.classList.add("preloader__text-cover--is-not-hidding")
  preloader.classList.add("preloader--is-not-visible")
  setTimeout(function(){ document.body.style.overflow = "" }, 5000);
}

const scrollTop = () => {
  window.scrollTo(0, 0)
  setTimeout(function(){ hideLoader() }, 300);
}

const firstVisitCheck = () => {
  if ( sessionStorage.getItem("doNotShow") == "true" ) {
    const preloader = document.querySelector(".preloader-js")
    preloader.classList.add("preloader--skipped")
  } else {
    scrollTop();
    sessionStorage.setItem("doNotShow", "true");
  };
}

export { firstVisitCheck }
