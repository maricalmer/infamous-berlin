// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
// import JQuery from 'jquery';
// window.$ = window.JQuery = JQuery;
import '../libraries/bootstrap_js_files.js';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initChatroomCable } from '../channels/chatroom_channel';
import { switchTabs } from '../components/tabs';
import { scrollOnArrows, hideArrowsOnScroll, changeImgDesktop, checkOnImgsState, switchImgWithDots, switchImgWithSwipe } from '../components/carousel';

document.addEventListener('turbolinks:load', () => {
  if (document.querySelectorAll(".messages").length) {
    initChatroomCable();
  };
  if (document.querySelectorAll(".tab-underlined").length) {
    switchTabs();
  };
  if (document.querySelectorAll(".arrow-up").length || document.querySelectorAll(".arrow-down").length) {
    scrollOnArrows();
  };
  if (document.querySelectorAll(".thumbnails").length) {
    switchImgWithDots();
    switchImgWithSwipe();
    hideArrowsOnScroll();
    checkOnImgsState();
  };
  if (document.querySelectorAll(".slide-thumbnail").length) {
    changeImgDesktop();
  };
  // Call your functions here, e.g:
  // initSelect2();
});
