const updateNavbar = () => {
  const logo = document.querySelector(".logo-js");
  const burger = document.querySelector(".burger-js");

  if (window.scrollY >= 40 && logo) {
    logo.classList.add("brand-wrapper-visible");
    if (burger) burger.classList.add("hamburger-wrapper-visible");
  } else if (logo) {
    logo.classList.remove("brand-wrapper-visible");
    if (burger) burger.classList.remove("hamburger-wrapper-visible");
  }
}

const hideNavbarOnScroll = () => {
  document.addEventListener("scroll", updateNavbar);
}

export { hideNavbarOnScroll }
