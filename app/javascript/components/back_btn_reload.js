const clearCachesOnBckBtn = () => {
  window.addEventListener("popstate", function() {
    window.location.reload();
  })
}

export { clearCachesOnBckBtn }
