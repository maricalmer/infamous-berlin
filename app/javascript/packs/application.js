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
import { switchSearchTabs } from '../components/search_tabs';
import { switchModalTabs } from '../components/modal_tabs';
import { scrollOnArrows, hideArrowsOnScroll, changeImgDesktop, checkOnFilesState, switchImgWithDots, switchImgWithSwipe } from '../components/carousel';
import { loadGalleryOnTabClick, loadGallery } from '../components/gallery';
import { expandSearchBar } from '../components/search';
import { autocompleteSearch } from '../components/autocomplete';
import { listenInput } from '../components/results_update';
import { initFlatpickr } from '../components/datepicker';
import { xScrollOnArrows, hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';
import { addNewMember } from '../components/new_member_form';
import { renderDashboardDropdown } from '../components/dropdown_links';
import { hideNavbarOnScroll } from '../components/navbar';
import { openBar } from '../components/search_navbar';
import { showSpinnerBtn } from '../components/spinner_btn';
import { renderPreview } from '../components/file_preview';
import { addSkill, populateList, disableEnterSubmit } from '../components/add_skill';
import { setDropdown } from '../components/switch_payment_rate';
import { setBackBtn } from '../components/back_dash_btn';
import { initGristack } from '../components/gridstack';


document.addEventListener('turbolinks:load', () => {
  if (document.querySelectorAll(".messages").length) {
    initChatroomCable();
  };
  if (document.querySelectorAll(".js-tab").length) {
    switchSearchTabs();
  };
  if (document.querySelectorAll(".js-modal-tab").length) {
    switchModalTabs();
  };
  if (document.querySelectorAll(".arrow-up").length || document.querySelectorAll(".arrow-down").length) {
    scrollOnArrows();
  };
  if (document.querySelectorAll(".past-chevron-left").length || document.querySelectorAll(".upcoming-chevron-left").length) {
    xScrollOnArrows();
  };
  if (document.querySelectorAll(".thumbnails").length) {
    switchImgWithDots();
    switchImgWithSwipe();
    hideArrowsOnScroll();
    checkOnFilesState();
  };
  if (document.querySelectorAll(".dash-cards-slider").length) {
    hideArrowsOnXScroll();
    checkOnDashImgsState();
  };
  if (document.querySelectorAll(".slide-thumbnail").length) {
    changeImgDesktop();
  };
  if (document.querySelectorAll(".tab-underlined").length) {
    // loadGalleryOnTabClick();
  };
  if (document.querySelectorAll(".grid-search").length) {
    // loadGallery();
  };
  if (document.querySelectorAll(".users-index-js").length ||
    document.querySelectorAll(".new-project-js").length ||
    document.querySelectorAll(".project-show-js").length) {
    autocompleteSearch();
  };
  if (document.querySelectorAll(".datepicker").length) {
    initFlatpickr();
  };
  if (document.querySelectorAll(".search-refresh-input").length) {
    loadGallery();
    listenInput();
  };
  if (document.querySelectorAll(".masonry-js").length) {
    loadGallery();
  };
  if (document.querySelectorAll(".btn-covering-js").length) {
    addNewMember();
  }
  if (document.querySelectorAll(".dropdown-links-js").length) {
    renderDashboardDropdown();
  }
  if (document.querySelectorAll(".logo-js").length) {
    hideNavbarOnScroll();
  }
  if (document.querySelectorAll(".burger-search-btn-js").length) {
    openBar();
    // ^^ is it working on homepage?
  }
  if (document.querySelectorAll(".form-btn-js").length) {
    showSpinnerBtn();
  }
  if (document.querySelectorAll(".placeholder-preview-js").length) {
    renderPreview();
  }
  if (document.querySelectorAll(".btn-add-skill-js").length) {
    addSkill();
    populateList();
    disableEnterSubmit();
  }
  if (document.querySelectorAll(".dropdown-payment-js").length) {
    setDropdown();
  }
  if (document.querySelectorAll(".back-dash-link-js").length) {
    setBackBtn();
  }
  if (document.querySelectorAll(".gridstack-js").length) {
    initGristack();
  }
    // expandSearchBar();

  // Call your functions here, e.g:
  // initSelect2();
});
