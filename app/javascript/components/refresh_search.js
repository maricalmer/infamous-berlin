import { highlight } from '../components/highlight_search_query';
import { alignSafariGridItems } from '../components/align_grid_items_on_safari';

const refreshIndex = () => {
  const inputTarget = document.querySelector(".refresh-input-js")
  const searchForm = document.querySelector(".search-form-js")
  const searchResults = document.querySelector(".search-results-js")
  const checkboxLabels = document.querySelectorAll(".checkbox-label-js")
  let params = ""
  checkboxLabels.forEach((checkboxLabel) => {
    if (checkboxLabel.previousElementSibling.checked ) {
      params = `&${checkboxLabel.previousElementSibling.name}=${checkboxLabel.previousElementSibling.value}`
    }
  })
  const url = `${searchForm.action}?query=${inputTarget.value}${params}`
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      searchResults.outerHTML = data;
      highlight();
      alignSafariGridItems();
    })
}

const listenSearchInput = () => {
  const inputTarget = document.querySelector(".refresh-input-js")
  inputTarget.addEventListener("keyup", refreshIndex);
}

export { listenSearchInput }
