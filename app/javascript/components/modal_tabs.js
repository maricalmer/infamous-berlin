import { loadGallery } from '../components/masonry';

const switchModalTabs = () => {
  const tabs = document.querySelectorAll('.js-modal-tab');
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

const renderPartial = (tab) => {
  const url = tab.href;
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      const results = tab.parentElement.parentElement.nextElementSibling
      results.innerHTML = data;
      loadGallery();
    })
}

export { switchModalTabs };
