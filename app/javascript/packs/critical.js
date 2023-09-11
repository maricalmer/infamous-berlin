require("@rails/ujs").start()
require("turbolinks").start()

import { initCursor } from '../components/homepage_cursor';
import { firstVisitCheck } from '../components/homepage_preloader';
import { homepageSlides } from '../components/homepage_slides';

document.addEventListener('turbolinks:load', () => {
  if (document.querySelectorAll(".homepage-slides-js").length) {
    homepageSlides();
  }
  if (document.querySelectorAll(".preloader-js").length) {
    firstVisitCheck();
  }
  if (document.querySelectorAll(".homepage-cursor-js").length) {
    initCursor();
  }
});
