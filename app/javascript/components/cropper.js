import Cropper from 'cropperjs';

const initCropper = () => {
  const images = document.querySelectorAll('.tag-cropper-js');
  images.forEach((img) => {
    const cropper = new Cropper(img, {
      aspectRatio: 16 / 9,
      crop(event) {
        console.log(event.detail.x);
        console.log(event.detail.y);
        console.log(event.detail.width);
        console.log(event.detail.height);
        console.log(event.detail.rotate);
        console.log(event.detail.scaleX);
        console.log(event.detail.scaleY);
      },
    });
  })
}

export { initCropper };
