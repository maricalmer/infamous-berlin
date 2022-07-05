const reloadWindowonBackBtn = () => {
  window.addEventListener("popstate", function() {
    console.log("reload")
    window.location.reload();
  })
}

export { reloadWindowonBackBtn }
