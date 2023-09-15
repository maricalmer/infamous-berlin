// filtered search
import { highlight } from '../components/highlight_search_query';
import { alignSafariGridItems } from '../components/align_grid_items_on_safari';

const listenCategories = () => {
  const checkboxLabels = document.querySelectorAll(".checkbox-label-js")
  checkboxLabels.forEach((label) => {
    label.previousElementSibling.addEventListener('change', (event) => {
      const form = document.querySelector(".search-form-js")
      const status = event.currentTarget.value
      const url = `${form.action}?query=${form[0].value}&${event.currentTarget.name}=${event.currentTarget.value}`
      fetch(url, { headers: { 'Accept': 'text/plain' } })
        .then(response => response.text())
        .then((data) => {
          const results = document.querySelector(".render-results-js");
          results.innerHTML = data;
          highlight();
          alignSafariGridItems();
        })
    })
  })
}

export { listenCategories }
