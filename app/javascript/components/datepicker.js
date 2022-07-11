import flatpickr from "flatpickr";
require("flatpickr/dist/themes/dark.css");


const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true
  });
}

export { initFlatpickr };
