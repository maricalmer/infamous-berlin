const hideBtnShowForm = (event) => {
  event.currentTarget.classList.add("btn-covering-hide")
  const form = document.querySelector(".new-member-form-js")
  form.classList.add("new-member-form-show")
}

const addNewMember = () => {
  const btnCovering = document.querySelector(".btn-covering-js")
  btnCovering.addEventListener("click", hideBtnShowForm)
}

export { addNewMember };
