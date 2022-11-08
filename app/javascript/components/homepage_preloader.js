const hideLoader = () => {
  document.body.style.overflow = "hidden"
  const hide = document.querySelector(".preloader-hide-js")
  const loader = document.querySelector(".preloader-js")
  hide.classList.add("is-not-hidding")
  loader.classList.add("is-not-visible")
  setTimeout(function(){ document.body.style.overflow = "" }, 5000);
}

const scrollTop = () => {
  window.scrollTo(0, 0)
  setTimeout(function(){ hideLoader() }, 300);
}

const firstVisitCheck = () => {
  if ( sessionStorage.getItem("doNotShow") == "true" ) {
    const loader = document.querySelector(".preloader-js")
    loader.classList.add("dont-display")
  } else {
    scrollTop();
    sessionStorage.setItem("doNotShow", "true");
  };
}

export { firstVisitCheck }
