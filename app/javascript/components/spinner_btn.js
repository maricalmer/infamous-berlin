const showSpinnerBtn = () => {
  const form = document.querySelector(".form-js");
  const btns = document.querySelectorAll(".form-btn-js");
  form.addEventListener("submit", (event) => {
    btns.forEach((btn) => {
      btn.classList.toggle("form-page__loading-btn--hidden")
    })
  })
}

export { showSpinnerBtn }
