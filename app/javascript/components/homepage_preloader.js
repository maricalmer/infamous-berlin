const hideLoader = () => {
  document.body.style.overflow = "hidden"
  const loader = document.querySelector(".preloader")
  const hide = document.querySelector(".preloader-hide")
  hide.classList.add("is-not-hidding")
  loader.classList.add("is-not-visible")
  setTimeout(function(){ document.body.style.overflow = "" }, 5000);
}

const scrollTop = () => {
  window.scrollTo(0, 0)
  setTimeout(function(){ hideLoader() }, 300);
}

export { scrollTop }
