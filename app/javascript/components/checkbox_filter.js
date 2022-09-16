// STILL IN USE??

import { highlight } from '../components/highlight_search_query';
import { loadGallery } from '../components/masonry';

const listenCheckboxes = () => {
  const checkboxeLabels = document.querySelectorAll(".checkbox-label-js")
  checkboxeLabels.forEach((label) => {
    label.previousElementSibling.addEventListener('change', (event) => {
      const form = document.querySelector(".search-form-js")
      const url = `${form.action}?query=${form[0].value}&${event.currentTarget.name}=${event.currentTarget.value}`
      fetch(url, { headers: { 'Accept': 'text/plain' } })
        .then(response => response.text())
        .then((data) => {
          const results = document.querySelector(".render-results-js");
          results.innerHTML = data;
          highlight()
          const masonry = document.querySelector(".masonry-js")
          if (masonry) {
            loadGallery()
          }
        })
    })
  })
}

export { listenCheckboxes }
