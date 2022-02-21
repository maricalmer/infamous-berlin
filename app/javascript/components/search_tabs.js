import { loadGallery } from '../components/gallery';
import { hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';

const switchSearchTabs = () => {
  const tabs = document.querySelectorAll('.js-tab');
  tabs.forEach((tab) => {
    tab.addEventListener('click', (event) => {
      const lis = event.target.parentElement.parentElement.childNodes;
      lis.forEach((li) => {
        if (li.nodeName == "LI") {
          li.firstElementChild.classList.remove("tab-active");
        }
      });
      event.target.classList.add("tab-active");
      renderPartial(tab);
    });
  });
}

const insertResults = (cssClass, data) => {
  const results = document.querySelector(cssClass);
  results.outerHTML = data;
}

const renderPartial = (tab) => {
  const url = tab.href;
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      const results = document.querySelector(".js-results");
      results.innerHTML = data;
      const grid = document.querySelector(".grid-search");
      if (grid) {
        loadGallery();
      };
      // const arrowsLeft = document.querySelectorAll(".past-chevron-left");
      // if (arrowsLeft) {
      //   checkOnDashImgsState();
      //   hideArrowsOnXScroll();
      // };
    })
}

export { switchSearchTabs };
