import "stylesheets/critical.scss";

require("turbolinks").start()

import '../libraries/bootstrap_js_files.js';
import { initCursor } from '../components/homepage_cursor';
import { firstVisitCheck } from '../components/homepage_preloader';
import { homepageSlides } from '../components/homepage_slides';
import { triggerTyped } from '../components/typed';

document.addEventListener('turbolinks:load', () => {
  if (document.querySelectorAll(".homepage-cursor-js").length) {
    initCursor();
  }
  if (document.querySelectorAll(".preloader-js").length) {
    firstVisitCheck();
  }
  if (document.querySelectorAll(".homepage-slides-js").length) {
    homepageSlides();
  }
  if (document.querySelectorAll(".typed-js").length) {
    triggerTyped();
  }
});
