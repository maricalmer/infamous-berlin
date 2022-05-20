const reloadWindowonBackBtn = () => {
  window.addEventListener("popstate", function() {
    window.location.reload();
  })
}

export { reloadWindowonBackBtn }
