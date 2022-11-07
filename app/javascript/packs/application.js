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
import { addAttribute, populateList, disableEnterSubmit } from '../components/add_array_attributes';
import { autocompleteSearch } from '../components/autocomplete';
import { reloadWindowOnBackBtn } from '../components/back_btn_reload';
import { scrollOnArrows, hideArrowsOnScroll, changeImgDesktop, checkOnFilesState, switchImgWithDots, switchImgWithSwipe } from '../components/carousel';
import { attachCropperEvents } from '../components/cropper';
import { initFlatpickr } from '../components/datepicker';
import { renderDashboardDropdown } from '../components/dropdown_dashboard_menus';
import { renderPreview } from '../components/file_preview';
import { clickOnFilter } from '../components/filter_btn_covering_effect';
import { initGristackEdit, setSaveBtn } from '../components/gridstack_edit';







import { listenCategories } from '../components/index_category_filter';


import { initChatroomCable } from '../channels/chatroom_channel';
import { switchSearchTabs } from '../components/search_tabs';
import { switchModalTabs } from '../components/modal_tabs';
import { expandSearchBar } from '../components/search';
// import { listenInput } from '../components/results_update';
import { listenSearchInput } from '../components/refresh_search';

import { xScrollOnArrows, hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';
import { addNewMember } from '../components/new_member_form';
import { hideNavbarOnScroll } from '../components/navbar';
import { openBar } from '../components/search_navbar';
import { showSpinnerBtn } from '../components/spinner_btn';

import { setDropdown } from '../components/switch_payment_rate';

import { initGristackStatic } from '../components/gridstack_static';

import { fixBtnOnScroll } from '../components/save_display_btn';
import { playFileOnClick } from '../components/play_audio_file';
import { highlight } from '../components/highlight_search_query';


import { firstVisitCheck } from '../components/homepage_preloader';
import { triggerTyped } from '../components/typed';
import { delayHomepageSlides } from '../components/homepage_slides';
import { initCursor } from '../components/homepage_cursor';


document.addEventListener('turbolinks:load', () => {
  if (document.querySelectorAll(".btn-add-attribute-js").length) {
    addAttribute();
    populateList();
    disableEnterSubmit();
  }
  if (document.querySelectorAll(".users-index-js").length ||
    document.querySelectorAll(".new-project-js").length ||
    document.querySelectorAll(".project-show-js").length) {
    autocompleteSearch();
  };
  if (document.querySelectorAll(".bck-btn-reload-js").length) {
    reloadWindowOnBackBtn();
  }
  if (document.querySelectorAll(".arrow-up-js").length || document.querySelectorAll(".arrow-down-js").length) {
    scrollOnArrows();
  };
  if (document.querySelectorAll(".thumbnails-js").length) {
    switchImgWithDots();
    switchImgWithSwipe();
    hideArrowsOnScroll();
    checkOnFilesState();
  };
  if (document.querySelectorAll(".slide-thumbnail").length) {
    changeImgDesktop();
  };
  if (document.querySelectorAll(".tag-cropper-js").length) {
    attachCropperEvents();
  }
  if (document.querySelectorAll(".datepicker-js").length) {
    initFlatpickr();
  };
  if (document.querySelectorAll(".dropdown-links-js").length) {
    renderDashboardDropdown();
  }
  if (document.querySelectorAll(".placeholder-preview-js").length) {
    renderPreview();
  }
  if (document.querySelectorAll(".filter-effect-js").length) {
    clickOnFilter();
  }
  if (document.querySelectorAll(".gridstack-edit-js").length) {
    initGristackEdit()
    setSaveBtn();
  }
// ---------
  if (document.querySelectorAll(".checkbox-label-js").length) {
    listenCategories();
  }
  if (document.querySelectorAll(".messages-js").length) {
    initChatroomCable();
  };
  if (document.querySelectorAll(".js-tab").length) {
    switchSearchTabs();
  };
  if (document.querySelectorAll(".js-modal-tab").length) {
    switchModalTabs();
  };
  if (document.querySelectorAll(".past-chevron-left").length || document.querySelectorAll(".upcoming-chevron-left").length) {
    xScrollOnArrows();
  };
  if (document.querySelectorAll(".dash-cards-slider").length) {
    hideArrowsOnXScroll();
    checkOnDashImgsState();
  };

  if (document.querySelectorAll(".search-form-js").length) {
    listenSearchInput();
  };
  if (document.querySelectorAll(".btn-covering-js").length) {
    addNewMember();
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
  if (document.querySelectorAll(".dropdown-payment-js").length) {
    setDropdown();
  }
  if (document.querySelectorAll(".gridstack-static-js").length) {
    initGristackStatic()
  }
  if (document.querySelectorAll(".save-display-btn-js").length) {
    fixBtnOnScroll();
  }
  if (document.querySelectorAll(".play-audio-js").length) {
    playFileOnClick();
  }
  if (document.querySelectorAll(".highlight-js").length) {
    highlight();
  }
  if (document.querySelectorAll(".preloader").length) {
    firstVisitCheck();
  }
  if (document.querySelectorAll(".typed-js").length) {
    triggerTyped();
  }
  if (document.querySelectorAll(".homepage-slides-js").length) {
    delayHomepageSlides();
  }
  if (document.querySelectorAll(".homepage-cursor-js").length) {
    initCursor();
  }
});
