// animation on filter selection for job and project search
const clickOnFilter = () => {
  const filterBtns = document.querySelectorAll(".filter-effect-js")
  const text = document.querySelector(".hide-filter-text-js")
  const radionBtns = document.querySelector(".show-radio-btns-js")
  filterBtns.forEach((btn) => {
    btn.addEventListener("click", function() {
      text.classList.toggle("search-bar-and-filters__cover--folded")
      radionBtns.classList.toggle("search-bar-and-filters__filter-options--shown")
    })
  })
}

export { clickOnFilter };
