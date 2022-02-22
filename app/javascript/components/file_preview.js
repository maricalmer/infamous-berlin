const resetFilePath = () => {
  const placeholder = document.querySelector(".placeholder-preview-js");
  placeholder.innerHTML = "";
  frame.classList.add("diamond-wrapper-form-hidden")
}

const catchFilePath = () => {
  if (event.target.files.length === 1) {
    const imgUri = event.target.files[0]
    const placeholder = document.querySelector(".placeholder-preview-js");
    const frame = document.querySelector(".diamond-wrapper-js");
    placeholder.outerHTML = `<img class="placeholder-preview-js" src=${URL.createObjectURL(imgUri)}>`;
    frame.classList.remove("diamond-wrapper-form-hidden")
  } elsif (event.target.files.length > 1) {
    for (let i = event.target.files.length - 1; i < event.target.files.length; i++) {
      const imgUri = event.target.files[i]
      const placeholder = document.querySelector(".placeholder-preview-js");
      const frame = document.querySelector(".diamond-wrapper-js");
      placeholder.outerHTML = `<img class="placeholder-preview-js" src=${URL.createObjectURL(imgUri)}>`;
      frame.classList.remove("diamond-wrapper-form-hidden")
    }
  }
}

const renderPreview = () => {
  const uploadBtnUser = document.getElementById("user_photo")
  const uploadBtnProject = document.getElementById("project_photos")
  // uploadBtn.addEventListener("click", resetFilePath)
  // uploadBtn.addEventListener("touchstart", resetFilePath)
  if (uploadBtnUser) {
    uploadBtnUser.addEventListener("change", catchFilePath)
  }
  if (uploadBtnProject) {
    uploadBtnProject.addEventListener("change", catchFilePath)
  }
}

export { renderPreview }
