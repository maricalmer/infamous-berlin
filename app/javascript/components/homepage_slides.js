let nextSection = null, section = null, sections = null, viewportSection = null

// const isInViewport = (element) => {
//   const rect = element.getBoundingClientRect();
//   return (
//     rect.top >= 0 &&
//     rect.left >= 0 &&
//     rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
//     rect.right <= (window.innerWidth || document.documentElement.clientWidth)
//   );
// }
const hideTapMobileBtn = () => {
  const btn = document.querySelector(".tap-your-screen-btn")
  if (btn) {
    btn.classList.toggle("hide-btn")
  }
}
const moveSections = () => {
  const openModal = document.querySelectorAll(".modal.show").length > 0
  sections = document.querySelectorAll('[class*="layer"]')
  viewportSection = Array.from(sections).filter( section => section.classList.contains("section-in-viewport-js") == true )
  if (!openModal) {
    if (viewportSection.length === 1) {
      nextSection = document.querySelector(".s2")
      nextSection.style.transform = 'translateX(-100vw)'
      nextSection.classList.remove("backwards")
      nextSection.classList.add("section-in-viewport-js")
    } else if (viewportSection.length === 2) {
      section = document.querySelector(".s2")
      if (section.classList.contains("backwards")) {
        section.style.transform = 'translateX(100vw)'
        section.classList.remove("section-in-viewport-js")
      } else {
        nextSection = document.querySelector(".s3")
        nextSection.style.transform = 'translateY(-200vh)'
        nextSection.classList.add("section-in-viewport-js")
        section.classList.add("backwards")
        setTimeout(() => {
          hideTapMobileBtn()
        }, 400)
      }
    } else if (viewportSection.length === 3) {
      nextSection = document.querySelector(".s3")
      nextSection.style.transform = 'translateY(200vh)'
      nextSection.classList.remove("section-in-viewport-js")
      setTimeout(() => {
        hideTapMobileBtn()
      }, 200)
    }
  }
}
const homepageSlides = () => {
  const homepage = document.querySelector(".homepage");
  const tapBtn = document.querySelector(".tap-your-screen-btn");
  homepage.addEventListener("click", moveSections)
  tapBtn.addEventListener("click", moveSections)
  const exits = document.querySelectorAll(".scroll-event-exit-js")
  exits.forEach((exit) => {
    exit.addEventListener("click", function() {
      // window.removeEventListener('click', moveSections);
    })
  })
}
const delayHomepageSlides = () => {
  homepageSlides()
}

export { delayHomepageSlides }
