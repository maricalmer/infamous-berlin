// add category or skill attribute(s) in create / update form for users, jobs or projects
const removeAttribute = () => {
  event.currentTarget.parentElement.remove()
  const attributes_input_field = document.querySelector(".attributes_hidden_field_js")
  let attribute = event.currentTarget.previousElementSibling.textContent
  if (attribute.includes(" ")) {
    attribute = attribute.replaceAll(" ", "_")
  }
  attributes_input_field.value = attributes_input_field.value.replace(attribute, "")
}

const triggerDeleteBtns = () => {
  const deleteBtns = document.querySelectorAll(".btn-delete-attribute-js")
  deleteBtns.forEach((btn) => {
    btn.addEventListener("click", removeAttribute)
  })
}

const pushToList = () => {
  let attribute = document.querySelector(".attribute-value-js").value
  if (attribute != "") {
    const list = document.querySelector(".attributes-list-js")
    list.innerHTML += `<ul class="form-page__attributes-list-item"><span>${attribute}</span><div class='btn-delete-attribute-js btn-delete-skill'>&#x2716;</div></ul>`
    if (attribute.includes(" ")) {
      attribute = attribute.trim().replaceAll(" ", "_")
    }
    const attributes_input_field = document.querySelector(".attributes_hidden_field_js")
    attributes_input_field.value = attributes_input_field.value.concat(' ', attribute)
  }
  triggerDeleteBtns();
  document.querySelector(".attribute-value-js").value = "";
}

const populateList = () => {
  const list = document.querySelector(".attributes-list-js")
  list.innerHTML = "";
  const attributes_input_field = document.querySelector(".attributes_hidden_field_js")
  attributes_input_field.value.split(" ").forEach((attribute) => {
    if (attribute != "") {
      if (attribute.includes("_")) {
        attribute = attribute.replaceAll("_", " ")
      }
      list.innerHTML += `<ul class="form-page__attributes-list-item"><span>${attribute}</span><div class='btn-delete-attribute-js btn-delete-skill'>&#x2716;</div></ul>`
    }
  })
  triggerDeleteBtns();
}

const addAttribute = () => {
  const addBtn = document.querySelector(".btn-add-attribute-js")
  addBtn.addEventListener("click", pushToList)
}

const disableEnterSubmit = () => {
  const attributeField = document.querySelector(".attribute-value-js")
  attributeField.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
      event.preventDefault();
    }
  });
}

export { addAttribute, populateList, disableEnterSubmit }
