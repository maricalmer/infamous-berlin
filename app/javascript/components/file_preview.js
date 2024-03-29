const updateFilesList = (index) => {
  let initialFiles = document.querySelector(".project-attachments-upload-btn-js")
  const initialArray = Array.from(initialFiles.files)
  initialArray.splice(index, 1)
  let newList = new DataTransfer();
  initialArray.forEach((file)=>{
    newList.items.add(file);
  })
  initialFiles.files = newList.files;
}
const setupDeleteBtn = () => {
  const btnsUploadedImg = document.querySelectorAll(".delete-signed-id-js")
  btnsUploadedImg.forEach((btn) => {
    btn.addEventListener("click", function(event) {
      event.currentTarget.parentElement.outerHTML = ""
    })
  })
  const btnsPreviewedImg = document.querySelectorAll(".delete-previewed-js")
  btnsPreviewedImg.forEach((btn) => {
    btn.addEventListener("click", function(event) {
      const index = event.currentTarget.previousElementSibling.getAttribute("index")
      updateFilesList(index);
      event.currentTarget.parentElement.outerHTML = ""
    })
  })
}
const displayDeleteBtn = (img, placeholder) => {
  const deleteWrapper = document.createElement("div")
  deleteWrapper.classList.add("form-page__preview-delete-wrapper", "delete-previewed-js")
  const deleteBtn = document.createElement("div")
  const deleteBtnContent = document.createTextNode("✖")
  deleteBtn.appendChild(deleteBtnContent)
  deleteBtn.classList.add("form-page__preview-delete-btn")
  const previewCard = document.createElement("div")
  previewCard.classList.add("form-page__preview-photo-wrapper", "preview-img-js")
  deleteWrapper.appendChild(deleteBtn)
  previewCard.appendChild(img)
  previewCard.appendChild(deleteWrapper)
  placeholder.append(previewCard)
}
const catchFilePathUserForm = (userAvatarUploadBtn) => {
  const fileInput = userAvatarUploadBtn.querySelector(".user-photo-js")
  if (fileInput.files.length > 0) {
    const imgUri = fileInput.files[0]
    const placeholder = document.querySelector(".placeholder-preview-js");
    const frame = document.querySelector(".diamond-wrapper-js");
    placeholder.outerHTML = `<img class="form-page__avatar-img placeholder-preview-js" src=${URL.createObjectURL(imgUri)}>`;
    frame.classList.remove("form-page__avatar-hidden")
  }
}
const catchFilePathProjectForm = (projectAttachmentsUploadBtn) => {
  const placeholder = document.querySelector(".placeholder-preview-js");
  const previewPhotos = document.querySelectorAll(".preview-img-js");
  previewPhotos.forEach( (photo) => { photo.outerHTML = "" });
  for (let i = 0; i < projectAttachmentsUploadBtn.files.length; i++) {
    if (projectAttachmentsUploadBtn.files[i].type === "video/mp4") {
      const file = document.createElement("video");
      const imgUri = projectAttachmentsUploadBtn.files[i];
      file.classList.add("form-page__preview-photo");
      file.src = URL.createObjectURL(imgUri);
      file.setAttribute("index", i);
      file.setAttribute("controls", "controls");
      file.setAttribute("muted", "muted");
      displayDeleteBtn(file, placeholder);
    } else if (projectAttachmentsUploadBtn.files[i].type === "audio/mpeg") {
      const file = document.createElement("video");
      const imgUri = projectAttachmentsUploadBtn.files[i];
      file.classList.add("form-page__preview-photo", "form-page__preview-photo--audio-poster");
      file.src = URL.createObjectURL(imgUri);
      file.setAttribute("index", i);
      file.setAttribute("controls", "controls");
      displayDeleteBtn(file, placeholder);
    } else {
      const file = document.createElement("img");
      const imgUri = projectAttachmentsUploadBtn.files[i];
      file.classList.add("form-page__preview-photo");
      file.src = URL.createObjectURL(imgUri);
      file.setAttribute("index", i);
      displayDeleteBtn(file, placeholder);
    }
  }
  setupDeleteBtn()
}
const renderPreview = () => {
  const error = document.querySelector(".invalid-feedback")
  if (error) {
    const preview = document.querySelector(".placeholder-preview-js")
    preview.innerHTML = ""
  }
  const userAvatarUploadBtn = document.querySelector(".user-avatar-upload-btn-js")
  const projectAttachmentsUploadBtn = document.querySelector(".project-attachments-upload-btn-js")
  if (userAvatarUploadBtn) {
    userAvatarUploadBtn.addEventListener("change", function(){
      catchFilePathUserForm(userAvatarUploadBtn);
    });
    catchFilePathUserForm(userAvatarUploadBtn);
  }
  if (projectAttachmentsUploadBtn) {
    projectAttachmentsUploadBtn.addEventListener("change", function(){
      catchFilePathProjectForm(projectAttachmentsUploadBtn);
    });
    if (projectAttachmentsUploadBtn.files) {
      catchFilePathProjectForm(projectAttachmentsUploadBtn);
    }
  }
}

export { renderPreview }
