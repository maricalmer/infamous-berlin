import { loadGallery } from '../components/gallery';

function updateResults() {
  const searchInput = document.querySelector(".search-refresh-input");
  const searchForm = document.querySelector(".search-refresh-form");
  const searchResults = document.querySelector(".search-refresh-results");
  const url = `${searchForm.action}?query=${searchInput.value}`
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      searchResults.innerHTML = data;
      loadGallery();
    })
}

const listenInput = () => {
  const searchInput = document.querySelector(".search-refresh-input");
  searchInput.addEventListener("keyup", updateResults);
}

export { listenInput };
