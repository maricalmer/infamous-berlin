const fixBtn = () => {
  const btn = document.querySelector(".save-display-btn-js");
  if (btn && window.scrollY >= 160) {
    btn.style.position="fixed";
    btn.style.top="67px";
  } else if (btn) {
    btn.style.position="absolute";
    btn.style.top="228px";
  }
}

const fixBtnOnScroll = () => {
  document.addEventListener("scroll", fixBtn);
}

export { fixBtnOnScroll }
