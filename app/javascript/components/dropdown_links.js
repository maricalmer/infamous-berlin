import { hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';

const hideChevrons = () => {
  const chevronLeft = document.querySelector(".past-chevron-left");
  chevronLeft.classList.add("chevron-hidden")
  const chevronRight = document.querySelector(".past-chevron-right");
  chevronRight.classList.add("chevron-hidden")
}

const renderPartial = (link) => {
  const url = link.href;
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      console.log(link)
      const results = link.parentElement.parentElement.parentElement.parentElement.nextElementSibling
      results.outerHTML = data;
      const arrowsLeft = document.querySelector(".past-chevron-left");
      if (arrowsLeft) {
        checkOnDashImgsState();
        hideArrowsOnXScroll();
      };
      const inquiries = document.querySelector(".inquiry-dash-js");
      if (inquiries) {
        hideChevrons();
      };
    })
}

const renderDashboardDropdown = (tab) => {
  const links = document.querySelectorAll('.dropdown-links-js');
  links.forEach((link) => {
    link.addEventListener('click', (event) => {
      renderPartial(link);
    });
  })
}

export { renderDashboardDropdown };
