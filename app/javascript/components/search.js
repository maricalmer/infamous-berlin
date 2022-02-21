var inputSearchBar = document.querySelector(".search-hamburger-input");
var searchBtn = document.querySelector(".search-hamburger-btn");

const toggleSearchBar = () => {
  searchBtn.classList.toggle("search-hamburger-close");
  inputSearchBar.classList.toggle("search-hamburger-square");
  inputSearchBar.classList.toggle("placeholder-transparent");
};

const expandSearchBar = () => {
  searchBtn.addEventListener("click", toggleSearchBar);
}

export { expandSearchBar };
