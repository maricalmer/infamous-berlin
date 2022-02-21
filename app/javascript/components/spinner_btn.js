const showSpinnerBtn = () => {
  const form = document.querySelector(".new-project-form-js");
  const btns = document.querySelectorAll(".form-btn-js");
  form.addEventListener("submit", (event) => {
    console.log(event)
    btns.forEach((btn) => {
      btn.classList.toggle("btn-hidden")
    })
  })
}

export { showSpinnerBtn }
