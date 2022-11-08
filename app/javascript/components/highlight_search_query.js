const highlight = () => {
  let term = document.querySelector(".user-input-highlight-js").value
  let text_fields = document.querySelectorAll(".highlight-query-js")
  text_fields.forEach((field)=>{
    let regex = new RegExp(term, 'gi')
    let response = field.innerText.replace(regex, function(str) {
      return "<span style='background-color: #cff170;'>" + str + "</span>"
    })
    field.innerHTML = response
  })
}

export { highlight }
