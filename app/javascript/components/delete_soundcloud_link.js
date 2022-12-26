const deleteSoundcloudLinks = () => {
  const iframes = document.querySelectorAll("iframe");
  iframes.forEach((iframe) => {
    if (iframe.nextElementSibling && iframe.nextElementSibling.innerHTML.includes("soundcloud.com")) {
      iframe.nextElementSibling.remove();
    }
  })
}

export { deleteSoundcloudLinks };
