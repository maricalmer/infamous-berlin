const TIME_OUT = 600 // same transition time of the sections
const body = document.querySelector('body')
const sectionsQty = document.querySelectorAll('section').length

let startFlag = true
let initialScroll = window.scrollY
let qty = 1, section = null

const changeNavColor = () => {
  const navElements = document.querySelectorAll(".nav-homepage-js")
  console.log(navElements)
  navElements.forEach((element)=>{
    if (qty === 2 && element.localName === "span") {
      element.style.background = "#d6d6d6"
    } else if ((qty === 2 && element.localName === "a") || (qty === 2 && element.localName === "li") || (qty === 2 && element.localName === "div")) {
      element.style.color = "#d6d6d6"
    } else if (element.localName === "span") {
      element.style.background = "black"
    } else if ((element.localName === "a") || (element.localName === "li") || (element.localName === "div")) {
      element.style.color = "black"
    }
  })
}

const moveSections = () => {
  if (startFlag) {
    const scrollDown = window.scrollY >= initialScroll
    const scrollLimit = qty >= 1 && qty <= sectionsQty
    if (scrollLimit) {
      body.style.overflowY = 'hidden' // Lock el scroll

      if (scrollDown && qty < sectionsQty) {
        section = document.querySelector(`.s${qty + 1}`)

        if (qty === 1) {
          section.style.transform = 'translateX(-100vw)'
        } else if (qty === 2) {
          section.style.transform = 'translateY(-100vh)'
        }

        qty++

        changeNavColor()

      } else if (!scrollDown && qty > 1) {
        section = document.querySelector(`.s${qty}`)

        if (qty === 3) {
          section.style.transform = 'translateY(-0vh)'
        } else if (qty === 2) {
          section.style.transform = 'translateX(100vw)'
        }

        qty--

        changeNavColor()
      }
    }

    console.log('SLIDE', qty)

    setTimeout(() => {
      initialScroll = window.scrollY
      startFlag = true
      body.style.overflowY = 'scroll'
    }, TIME_OUT)

    startFlag = false
  }

}

const homepageSlides = () => {
  window.addEventListener("scroll", moveSections)
  const exits = document.querySelectorAll(".scroll-event-exit-js")
  exits.forEach((exit) => {
    exit.addEventListener("click", function() {
      window.removeEventListener('scroll', moveSections);
    })
  })
}

const delayHomepageSlides = () => {
  setTimeout(homepageSlides, 600);
}

export { delayHomepageSlides }
