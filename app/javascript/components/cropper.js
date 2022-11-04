import Cropper from 'cropperjs';
require("cropperjs/dist/cropper.css");

const attachCropperEvents = () => {
  const modals = document.querySelectorAll(".modal-crop-portfolio-js")
  let cropper;
  let cropX;
  let cropY;
  let cropWidth;
  let cropHeight;
  modals.forEach((modal) => {
    modal.addEventListener("shown.bs.modal", function(event) {
      const img = event.currentTarget.firstElementChild.firstElementChild.children[1].firstElementChild.firstElementChild.children[1]
      const img_querySelector = event.currentTarget.querySelector(".tag-cropper-js")
      console.log(img)
      console.log(img_querySelector)
      const imgAndTitle = event.currentTarget.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling
      const imgAndTitle_closest = event.currentTarget.closest(".img-and-title-js")
      console.log(imgAndTitle)
      console.log(imgAndTitle_closest)
      const ratio = imgAndTitle.offsetWidth / (imgAndTitle.offsetHeight - 28)
      cropper = new Cropper(img, {
        dragMode: 'move',
        aspectRatio: ratio,
        autoCropArea: 0.95,
        restore: false,
        guides: false,
        center: false,
        highlight: false,
        cropBoxResizable: false,
        toggleDragModeOnDblclick: false,
        minContainerWidth: 465,
        minContainerHeight: 500,
        crop(event) {
          cropX = Math.round(event.detail.x)
          cropY = Math.round(event.detail.y)
          cropWidth = Math.round(event.detail.width)
          cropHeight = Math.round(event.detail.height)
        },
      });
      const cropBtn = event.currentTarget.firstElementChild.firstElementChild.lastElementChild.firstElementChild
      cropBtn.addEventListener("click", function(e) {
        const formCropX = e.currentTarget.offsetParent.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling[6]
        const formCropY = e.currentTarget.offsetParent.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling[7]
        const formCropHeight = e.currentTarget.offsetParent.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling[8]
        const formCropWidth = e.currentTarget.offsetParent.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling[9]
        formCropX.value = cropX
        formCropY.value = cropY
        formCropHeight.value = cropHeight
        formCropWidth.value = cropWidth
        const imgModel = e.currentTarget.parentElement.previousElementSibling.firstElementChild.firstElementChild.children[1]
        const imgPlaceholder = e.currentTarget.parentElement.parentElement.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.firstElementChild.children[1]
        const url_extra_crop = `upload/c_crop,h_${cropHeight},w_${cropWidth},x_${cropX},y_${cropY}`
        const url_parts = imgModel.src.split("upload")
        const url_crop = `${url_parts[0]}${url_extra_crop}${url_parts[1]}`
        if (imgModel.src.includes("/image/")) {
          imgPlaceholder.src = url_crop
        } else {
          imgPlaceholder.poster = url_crop
        }
        const formImgString = e.currentTarget.offsetParent.parentElement.parentElement.previousElementSibling.previousElementSibling.previousElementSibling[10]
        formImgString.value = url_crop
      })
    })
    modal.addEventListener("hidden.bs.modal", function() {
      cropper.destroy();
    })
  })
}

export { attachCropperEvents };
