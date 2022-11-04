const reloadWindowOnBackBtn = () => {
  window.addEventListener("popstate", function() {
    console.log("reload")
    window.location.reload();
  })
}

export { reloadWindowOnBackBtn }
