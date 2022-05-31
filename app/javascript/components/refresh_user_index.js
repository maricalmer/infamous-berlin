import { highlight } from '../components/highlight_search_query';

const refreshUserIndex = () => {
  const inputTarget = document.querySelector(".user-index-refresh-input-js")
  const searchForm = document.querySelector(".user-index-search-form-js")
  const searchResults = document.querySelector(".user-index-search-results-js")
  console.log(searchResults)
  const url = `${searchForm.action}?query=${inputTarget.value}`
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      searchResults.innerHTML = data;
      highlight()
    })
}

const listenInputUserIndex = () => {
  const inputTarget = document.querySelector(".user-index-refresh-input-js")
  inputTarget.addEventListener("keyup", refreshUserIndex);
}

export { listenInputUserIndex }
