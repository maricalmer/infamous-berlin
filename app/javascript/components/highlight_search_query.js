const query = () => {
  const query = window.location.search.substring(1);
  return query.split("query=")[1]
}

const highlight = () => {
  let term = query()
  let text_fields = document.querySelectorAll(".highlight-query-js")
  console.log(text_fields)
  text_fields.forEach((field)=>{
    field.innerHTML = field.innerHTML.replace(new RegExp(term, "gi"), (term) => `<span class="search-keyword-highlighted">${term}</span>`);
  })
}

export { highlight }



