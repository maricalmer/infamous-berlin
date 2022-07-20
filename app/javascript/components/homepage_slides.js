// const TIME_OUT = 2000 // same transition time of the sections
const body = document.querySelector('body')
const sectionsQty = document.querySelectorAll('section').length

// let startFlag = true
// let initialScroll = window.scrollY
let qty = 1, section = null, direction = "down"

// const changeNavColor = () => {
//   const navElements = document.querySelectorAll(".nav-homepage-js")
//   console.log(navElements)
//   navElements.forEach((element)=>{
//     if (qty === 2 && element.localName === "span") {
//       element.style.background = "#858585"
//     } else if ((qty === 2 && element.localName === "a") || (qty === 2 && element.localName === "li") || (qty === 2 && element.localName === "div")) {
//       element.style.color = "#858585"
//     } else if (element.localName === "span") {
//       element.style.background = "#858585"
//     } else if ((element.localName === "a") || (element.localName === "li") || (element.localName === "div")) {
//       element.style.color = "#858585"
//     }
//   })
// }

const moveSections = () => {
  // if (startFlag) {
    // const scrollDown = window.scrollY >= initialScroll + 0.5
    const clickLimit = qty >= 1 && qty <= sectionsQty
    if (clickLimit) {
      body.style.overflowY = 'hidden' // Lock el scroll

      if (direction == "down") {


        if (qty === 1) {
          section = document.querySelector(`.s${qty + 1}`)
          section.style.transform = 'translateX(-100vw)'
          qty++
        } else if (qty === 2) {
          section = document.querySelector(`.s${qty + 1}`)
          section.style.transform = 'translateY(-200vh)'
          qty++
        } else if (qty === 3) {
          section = document.querySelector(`.s${qty}`)
          section.style.transform = 'translateY(200vh)'
          direction = "up"
          qty--
        }

        // changeNavColor()

      } else if (direction == "up") {


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

        // changeNavColor()
      }
    }
    // console.log(startFlag)
    console.log('SLIDE', qty)
    console.log(direction)
    // console.log(window.scrollY)

    // setTimeout(() => {
    //   initialScroll = window.scrollY
    //   // startFlag = true
    //   body.style.overflowY = 'scroll'
    // }, TIME_OUT)

    // startFlag = false
  // }

}

const homepageSlides = () => {
  window.addEventListener("click", moveSections)
  const exits = document.querySelectorAll(".scroll-event-exit-js")
  exits.forEach((exit) => {
    exit.addEventListener("click", function() {
      window.removeEventListener('click', moveSections);
    })
  })
}

const delayHomepageSlides = () => {
  // setTimeout(homepageSlides, 1200);
  homepageSlides()
}

export { delayHomepageSlides }
