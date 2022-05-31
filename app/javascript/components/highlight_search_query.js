const query = () => {
  const userFormInput = document.querySelector(".user-input-highlight-js").value

  // if (userFormInput) {
    return userFormInput
  // } else {
  //   const urlQuery = window.location.search.substring(1);
  //   return urlQuery.split("query=")[1]
  // }
}

const highlight = () => {
  let term = query()
  let text_fields = document.querySelectorAll(".highlight-query-js")
  text_fields.forEach((field)=>{
    field.innerHTML = field.innerHTML.replace(new RegExp(term, "gi"), (term) => `<span class="search-keyword-highlighted">${term}</span>`);
  })
}

export { highlight }



