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
import { loadGalleryOnTabClick, loadGallery } from '../components/masonry';
import { expandSearchBar } from '../components/search';
import { autocompleteSearch } from '../components/autocomplete';
// import { listenInput } from '../components/results_update';
import { listenSearchInput } from '../components/refresh_search';
import { initFlatpickr } from '../components/datepicker';
import { xScrollOnArrows, hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';
import { addNewMember } from '../components/new_member_form';
import { renderDashboardDropdown } from '../components/dropdown_links';
import { hideNavbarOnScroll } from '../components/navbar';
import { openBar } from '../components/search_navbar';
import { showSpinnerBtn } from '../components/spinner_btn';
import { renderPreview } from '../components/file_preview';
import { addAttribute, populateList, disableEnterSubmit } from '../components/add_array_attributes';
import { setDropdown } from '../components/switch_payment_rate';
import { initGristackEdit, setSaveBtn } from '../components/gridstack_edit';
import { initGristackStatic } from '../components/gridstack_static';
import { attachCropperEvents } from '../components/cropper';
import { fixBtnOnScroll } from '../components/save_display_btn';
import { reloadWindowonBackBtn } from '../components/back_btn_reload';
import { playFileOnClick } from '../components/play_audio_file';
import { highlight } from '../components/highlight_search_query';
import { listenCheckboxes } from '../components/checkbox_filter';
import { clickOnFilter } from '../components/filter_radio_btn_effect';
import { firstVisitCheck } from '../components/homepage_preloader';
import { triggerTyped } from '../components/typed';


import { setGallery } from '../components/alternative_masonry';


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
  // if (document.querySelectorAll(".search-refresh-input").length) {
  //   loadGallery();
  //   listenInput();
  // };
  if (document.querySelectorAll(".search-form-js").length) {
    listenSearchInput();
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
  if (document.querySelectorAll(".btn-add-attribute-js").length) {
    addAttribute();
    populateList();
    disableEnterSubmit();
  }
  if (document.querySelectorAll(".dropdown-payment-js").length) {
    setDropdown();
  }
  if (document.querySelectorAll(".gridstack-edit-js").length) {
    initGristackEdit()
    setSaveBtn();
  }
  if (document.querySelectorAll(".gridstack-static-js").length) {
    initGristackStatic()
  }
  if (document.querySelectorAll(".tag-cropper-js").length) {
    attachCropperEvents();
  }
  if (document.querySelectorAll(".save-display-btn-js").length) {
    fixBtnOnScroll();
  }
  if (document.querySelectorAll(".job-show-js").length) {
    reloadWindowonBackBtn();
  }
  if (document.querySelectorAll(".play-audio-js").length) {
    playFileOnClick();
  }
  if (document.querySelectorAll(".highlight-js").length) {
    highlight();
  }
  if (document.querySelectorAll(".checkbox-label-js").length) {
    listenCheckboxes();
  }
  if (document.querySelectorAll(".filter-effect-js").length) {
    clickOnFilter();
  }
  if (document.querySelectorAll(".preloader").length) {
    firstVisitCheck();
  }
  if (document.querySelectorAll(".typed-js").length) {
    triggerTyped();
  }

  // Call your functions here, e.g:
  // initSelect2();
});

// document.addEventListener('DOMContentLoaded', () => {
//   if (document.querySelectorAll(".masonry-grid-js").length) {
//     setGallery();
//   }
// })
