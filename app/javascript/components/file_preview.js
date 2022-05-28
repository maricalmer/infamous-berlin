const resetFilePath = () => {
  const placeholder = document.querySelector(".placeholder-preview-js");
  placeholder.innerHTML = "";
  frame.classList.add("diamond-wrapper-form-hidden");
}
const updateFilesList = (index) => {
  let initialFiles = document.getElementById("project_attachments")
  const initialArray = Array.from(initialFiles.files)
  initialArray.splice(index, 1)
  console.log(initialArray)
  let newlist = new DataTransfer();
  initialArray.forEach((file)=>{
    newlist.items.add(file);
  })
  initialFiles.files = newlist.files;
  console.log(initialFiles.files)
  console.log(newlist.files)
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
  deleteWrapper.classList.add("wrapper-preview-delete", "delete-previewed-js")
  const deleteBtn = document.createElement("div")
  const deleteBtnContent = document.createTextNode("✖")
  deleteBtn.appendChild(deleteBtnContent)
  deleteBtn.classList.add("project-photo-preview-delete")
  const previewCard = document.createElement("div")
  previewCard.classList.add("project-photo-preview-card", "preview-img-js")
  deleteWrapper.appendChild(deleteBtn)
  previewCard.appendChild(img)
  previewCard.appendChild(deleteWrapper)
  placeholder.append(previewCard)
}
const catchFilePathUserForm = (uploadBtnUser) => {
  if (uploadBtnUser.files.length > 0) {
    const imgUri = uploadBtnUser.files[0]
    const placeholder = document.querySelector(".placeholder-preview-js");
    const frame = document.querySelector(".diamond-wrapper-js");
    placeholder.outerHTML = `<img class="placeholder-preview-js" src=${URL.createObjectURL(imgUri)}>`;
    frame.classList.remove("diamond-wrapper-form-hidden")
  }
}
const catchFilePathProjectForm = (uploadBtnProject) => {
  const placeholder = document.querySelector(".placeholder-preview-js");
  const previewPhotos = document.querySelectorAll(".preview-img-js");
  console.log(previewPhotos)
  previewPhotos.forEach( (photo) => { photo.outerHTML = "" });
  for (let i = 0; i < uploadBtnProject.files.length; i++) {
    if (uploadBtnProject.files[i].type === "video/mp4") {
      const file = document.createElement("video");
      const imgUri = uploadBtnProject.files[i];
      file.classList.add("project-photo-preview");
      file.src = URL.createObjectURL(imgUri);
      file.setAttribute("index", i);
      displayDeleteBtn(file, placeholder);
    } else if (uploadBtnProject.files[i].type === "audio/mpeg") {
      const file = document.createElement("img");
      const imgUri = uploadBtnProject.files[i];
      file.classList.add("project-photo-preview");
      file.src = "/assets/logo-audio.png";
      file.setAttribute("index", i);
      displayDeleteBtn(file, placeholder);
    } else {
      const file = document.createElement("img");
      const imgUri = uploadBtnProject.files[i];
      file.classList.add("project-photo-preview");
      file.src = URL.createObjectURL(imgUri);
      file.setAttribute("index", i);
      displayDeleteBtn(file, placeholder);
    }
  }
  setupDeleteBtn()
}
const renderPreview = () => {
  const uploadBtnUser = document.getElementById("user_photo")
  const uploadBtnProject = document.getElementById("project_attachments")
  // uploadBtn.addEventListener("click", resetFilePath)
  // uploadBtn.addEventListener("touchstart", resetFilePath)
  if (uploadBtnUser) {
    uploadBtnUser.addEventListener("change", function(){
      catchFilePathUserForm(uploadBtnUser);
    });
    catchFilePathUserForm(uploadBtnUser);
  }
  if (uploadBtnProject) {
    uploadBtnProject.addEventListener("change", function(){
      catchFilePathProjectForm(uploadBtnProject);
    });
    if (uploadBtnProject.files) {
      catchFilePathProjectForm(uploadBtnProject);
    }
    // setupDeleteBtn();
  }
}

export { renderPreview }
