import flatpickr from "flatpickr";
require("flatpickr/dist/themes/dark.css");


const initFlatpickr = () => {
  flatpickr(".datepicker-js", {
    altInput: true
  });
}

export { initFlatpickr };
