const alignSafariGridItems = () => {
  let isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
  if (isSafari) {
    const gridItems = document.querySelectorAll(".align-items-on-safari-js");
    gridItems.forEach((item) => {
      item.classList.add("project-card__wrapper--safari_only")
    })
  }
}

export { alignSafariGridItems }
