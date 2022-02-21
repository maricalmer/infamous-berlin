const openBar = () => {
  var searchBtn = document.querySelector(".burger-search-btn-js");
  console.log(searchBtn)
  searchBtn.addEventListener("click", function(){
    var inputSearchBar = document.querySelector(".burger-search-input-js");
    searchBtn.classList.toggle("search-hamburger-close");
    inputSearchBar.classList.toggle("search-hamburger-square");
  });
}

export { openBar }
