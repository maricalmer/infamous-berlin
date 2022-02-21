function updateNavbar() {
  const logo = document.querySelector(".logo-js");
  const burger = document.querySelector(".burger-js");

  if (window.scrollY >= 50) {
    logo.classList.add("brand-wrapper-visible");
    burger.classList.add("hamburger-wrapper-visible");
  } else {
    logo.classList.remove("brand-wrapper-visible");
    burger.classList.remove("hamburger-wrapper-visible");
  }
}

const hideNavbarOnScroll = () => {
  window.addEventListener("scroll", updateNavbar);
}

export { hideNavbarOnScroll }
