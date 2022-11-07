const clickOnFilter = () => {
  const filterBtns = document.querySelectorAll(".filter-effect-js")
  const text = document.querySelector(".hide-filter-text-js")
  const radionBtns = document.querySelector(".show-radio-btns-js")
  filterBtns.forEach((btn) => {
    btn.addEventListener("click", function() {
      text.classList.toggle("jobs-index-hidding-span-activated")
      radionBtns.classList.toggle("job-index-radio-buttons-shown")
    })
  })
}

export { clickOnFilter };
