let qty = 1, section = null, direction = "down"


const hideTapMobileBtn = () => {
  const btn = document.querySelector(".tap-your-screen-btn")
  if (btn) {
    btn.classList.toggle("hide-btn")
  }
}

const moveSections = () => {
  const openModal = document.querySelectorAll(".modal.show").length > 0
  if (direction == "down" && !openModal) {
    if (qty === 1) {
      section = document.querySelector(`.s${qty + 1}`)
      section.style.transform = 'translateX(-100vw)'
      qty++
    } else if (qty === 2) {
      section = document.querySelector(`.s${qty + 1}`)
      section.style.transform = 'translateY(-200vh)'
      qty++
      setTimeout(() => {
        hideTapMobileBtn()
      }, 400)
    } else if (qty === 3) {
      section = document.querySelector(`.s${qty}`)
      section.style.transform = 'translateY(200vh)'
      direction = "up"
      qty--
      setTimeout(() => {
        hideTapMobileBtn()
      }, 200)
    }
  } else if (direction == "up" && !openModal) {
    if (qty === 1) {
      section = document.querySelector(`.s${qty + 1}`)
      section.style.transform = 'translateX(-100vw)'
      direction = "down"
      qty++
    } else if (qty === 2) {
      section = document.querySelector(`.s${qty}`)
      section.style.transform = 'translateX(100vw)'
      qty--
    }
  }
}

const homepageSlides = () => {
  const homepage = document.querySelector(".homepage");
  homepage.addEventListener("click", moveSections)
  const exits = document.querySelectorAll(".scroll-event-exit-js")
  exits.forEach((exit) => {
    exit.addEventListener("click", function() {
      window.removeEventListener('click', moveSections);
    })
  })
}

const delayHomepageSlides = () => {
  homepageSlides()
}

export { delayHomepageSlides }
