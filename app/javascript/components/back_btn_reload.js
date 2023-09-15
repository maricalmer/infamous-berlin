// full reload to clear previous page state after clicking back button in browser
const reloadWindowOnBackBtn = () => {
  window.addEventListener("popstate", function() {
    window.location.reload();
  })
}

export { reloadWindowOnBackBtn }
