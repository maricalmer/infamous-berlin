let nextSection = null, section = null, sections = null, viewportSection = null

const hideTapMobileBtn = () => {
  const btn = document.querySelector(".tap-your-screen-btn-js")
  if (btn) {
    btn.classList.toggle("hide-btn")
  }
}
const moveSections = () => {
  const isModalClosed = document.querySelectorAll(".modal.show").length === 0
  sections = document.querySelectorAll('[class*="layer"]')
  viewportSection = Array.from(sections).filter( section => section.classList.contains("section-in-viewport-js") == true )
  if (isModalClosed) {
    if (viewportSection.length === 1) {
      nextSection = document.querySelector(".second-section-js")
      nextSection.style.transform = 'translateX(-100vw)'
      nextSection.classList.remove("backwards")
      nextSection.classList.add("section-in-viewport-js")
    } else if (viewportSection.length === 2) {
      section = document.querySelector(".second-section-js")
      if (section.classList.contains("backwards")) {
        section.style.transform = 'translateX(100vw)'
        section.classList.remove("section-in-viewport-js")
      } else {
        nextSection = document.querySelector(".third-section-js")
        nextSection.style.transform = 'translateY(-200vh)'
        nextSection.classList.add("section-in-viewport-js")
        section.classList.add("backwards")
        setTimeout(() => {
          hideTapMobileBtn()
        }, 400)
      }
    } else if (viewportSection.length === 3) {
      nextSection = document.querySelector(".third-section-js")
      nextSection.style.transform = 'translateY(200vh)'
      nextSection.classList.remove("section-in-viewport-js")
      setTimeout(() => {
        hideTapMobileBtn()
      }, 200)
    }
  }
}
const homepageSlides = () => {
  const homepage = document.querySelector(".homepage-slides-js");
  const tapBtn = document.querySelector(".tap-your-screen-btn-js");
  homepage.addEventListener("click", moveSections)
  tapBtn.addEventListener("click", moveSections)
}

export { homepageSlides }
