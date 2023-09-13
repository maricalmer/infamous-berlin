import Cropper from 'cropperjs';

const attachCropperEvents = () => {
  const modals = document.querySelectorAll(".modal-crop-portfolio-js")
  let cropper;
  let cropX;
  let cropY;
  let cropWidth;
  let cropHeight;
  modals.forEach((modal) => {
    modal.addEventListener("shown.bs.modal", function(event) {
      const img = event.currentTarget.querySelector(".tag-cropper-js")
      const imgAndTitle = event.currentTarget.parentElement.querySelector(".img-and-title-js")
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
      const cropBtn = event.currentTarget.querySelector(".crop-cropper-btn-js")
      cropBtn.addEventListener("click", function(e) {
        const formCropX = e.currentTarget.closest(".grid-search-big-item-wrapper-js").querySelector(".mirror-crop-x-js")
        const formCropY = e.currentTarget.closest(".grid-search-big-item-wrapper-js").querySelector(".mirror-crop-y-js")
        const formCropHeight = e.currentTarget.closest(".grid-search-big-item-wrapper-js").querySelector(".mirror-crop-h-js")
        const formCropWidth = e.currentTarget.closest(".grid-search-big-item-wrapper-js").querySelector(".mirror-crop-w-js")
        formCropX.value = cropX
        formCropY.value = cropY
        formCropHeight.value = cropHeight
        formCropWidth.value = cropWidth
        const imgModel = e.currentTarget.closest(".cropper-modal-popup-js").querySelector(".tag-cropper-js")
        const imgPlaceholder = e.currentTarget.closest(".grid-search-big-item-wrapper-js").querySelector(".grid-search-big-item-img-js")
        const url_extra_crop = `upload/c_crop,h_${cropHeight},w_${cropWidth},x_${cropX},y_${cropY}`
        const url_parts = imgModel.src.split("upload")
        const url_crop = `${url_parts[0]}${url_extra_crop}${url_parts[1]}`
        if (imgModel.src.includes("/image/")) {
          imgPlaceholder.src = url_crop
        } else {
          imgPlaceholder.poster = url_crop
        }
        const formImgString = e.currentTarget.closest(".grid-search-big-item-wrapper-js").querySelector(".mirror-form-submit-btn-js")

        formImgString.value = url_crop
      })
    })
    modal.addEventListener("hidden.bs.modal", function() {
      cropper.destroy();
    })
  })
}

export { attachCropperEvents };
