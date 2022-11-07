const reloadWindowOnBackBtn = () => {
  window.addEventListener("popstate", function() {
    window.location.reload();
  })
}

export { reloadWindowOnBackBtn }
