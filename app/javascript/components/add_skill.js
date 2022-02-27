const removeSkill = () => {
  event.currentTarget.parentElement.remove()
  const skills_input_field = document.getElementById("user_skills")
  const skill = event.currentTarget.previousElementSibling.textContent
  if (skill.includes(" ")) {
    skill = skill.replace(" ", "_")
  }
  skills_input_field.value = skills_input_field.value.replace(skill, "")
}

const triggerDeleteBtns = () => {
  const deleteBtns = document.querySelectorAll(".btn-delete-skill-js")
  deleteBtns.forEach((btn) => {
    btn.addEventListener("click", removeSkill)
  })
}

const pushToList = () => {
  let skill = document.querySelector(".skill-value-js").value
  if (skill != "") {
    const list = document.querySelector(".skills-list-js")
    list.innerHTML += `<ul class="list-skill"><span>${skill.toLowerCase()}</span><div class='btn-delete-skill-js btn-delete-skill'>&#x2716;</div></ul>`
    if (skill.includes(" ")) {
      skill = skill.trim().replace(" ", "_")
    }
    const skills_input_field = document.getElementById("user_skills")
    skills_input_field.value = skills_input_field.value.concat(' ', skill)
  }
  triggerDeleteBtns();
  document.querySelector(".skill-value-js").value = "";
}

const populateList = () => {
  const list = document.querySelector(".skills-list-js")
  list.innerHTML = "";
  const skills_input_field = document.getElementById("user_skills")
  skills_input_field.value.split(" ").forEach((skill) => {
    if (skill != "") {
      if (skill.includes("_")) {
        skill = skill.replace("_", " ")
      }
      list.innerHTML += `<ul class="list-skill"><span>${skill.toLowerCase()}</span><div class='btn-delete-skill-js btn-delete-skill'>&#x2716;</div></ul>`
    }
  })
  triggerDeleteBtns();
}

const addSkill = () => {
  const addBtn = document.querySelector(".btn-add-skill-js")
  addBtn.addEventListener("click", pushToList)
}

const disableEnterSubmit = () => {
  const skillField = document.querySelector(".skill-value-js")
  skillField.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
      event.preventDefault();
    }
  });
}

export { addSkill, populateList, disableEnterSubmit }
