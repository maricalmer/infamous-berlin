const resetFilePath = () => {
  const placeholder = document.querySelector(".placeholder-preview-js");
  placeholder.innerHTML = "";
  frame.classList.add("diamond-wrapper-form-hidden")
}

const catchFilePath = () => {
  const imgUri = event.target.files[0]
  if (imgUri) {
    const placeholder = document.querySelector(".placeholder-preview-js");
    const frame = document.querySelector(".diamond-wrapper-js");
    placeholder.outerHTML = `<img class="placeholder-preview-js" src=${URL.createObjectURL(imgUri)}>`;
    frame.classList.remove("diamond-wrapper-form-hidden")
  }
}

const renderPreview = () => {
  const uploadBtn = document.getElementById("user_photo")
  // uploadBtn.addEventListener("click", resetFilePath)
  // uploadBtn.addEventListener("touchstart", resetFilePath)
  uploadBtn.addEventListener("change", catchFilePath)
}

export { renderPreview }
