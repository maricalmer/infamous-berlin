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
  // console.log(text_fields)
  // text_fields.forEach((field)=>{
  //   field.innerHTML = field.innerHTML.replace(new RegExp(term, "gi"), (term) => `<span>alamierda</span>`);
  // })
  text_fields.forEach((field)=>{
    let regex = new RegExp(term, 'gi')
    let response = field.innerText.replace(regex, function(str) {
      return "<span style='background-color: yellow;'>" + str + "</span>"
    })
    field.innerHTML = response
  })
}

export { highlight }
