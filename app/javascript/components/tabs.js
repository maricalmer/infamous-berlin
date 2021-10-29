const switchTabs = () => {
  const tabs = document.querySelectorAll('.tab-underlined');
  tabs.forEach((tab) => {
    tab.addEventListener('click', (event) => {
      tabs.forEach((tab) => {
        tab.classList.remove("active");
      });
      event.target.classList.add("active");
    });
  });
}

export { switchTabs };
