const setBackBtn = () => {
  const btn = document.querySelector(".back-dash-link-js");
  btn.addEventListener("click", function() {
    history.back();
  })
}

export { setBackBtn }
