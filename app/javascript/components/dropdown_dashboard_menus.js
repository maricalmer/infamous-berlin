import { hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';

const hideChevrons = () => {
  const chevronLeft = document.querySelector(".past-chevron-left-js");
  chevronLeft.classList.add("chevron-hidden")
  const chevronRight = document.querySelector(".past-chevron-right-js");
  chevronRight.classList.add("chevron-hidden")
}

const renderPartial = (link) => {
  const url = link.href;
  fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      const resultsPlaceholder = document.querySelector(".slider-js")
      resultsPlaceholder.outerHTML = data;
      const arrowsLeft = document.querySelector(".past-chevron-left-js");
      if (arrowsLeft) {
        checkOnDashImgsState();
        hideArrowsOnXScroll();
      };
      const inquiriesSection = document.querySelector(".inquiry-dash-js");
      if (inquiriesSection) {
        hideChevrons();
      };
    })
}

const renderDashboardDropdown = () => {
  const links = document.querySelectorAll(".dropdown-links-js");
  links.forEach((link) => {
    link.addEventListener('click', (event) => {
      renderPartial(link);
      const arrow = document.querySelector(".mobile-dropdown-arrow-js");
      if (getComputedStyle(arrow).display === "block") {
        arrow.previousElementSibling.previousElementSibling.checked = false;
      }
    });
  })
}

export { renderDashboardDropdown };
