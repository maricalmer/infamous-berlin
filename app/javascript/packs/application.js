require("@rails/activestorage").start()
require("channels")
require("@rails/ujs").start()
require("turbolinks").start()

import '../libraries/bootstrap_js_files.js';
import { initChatroomCable } from '../channels/chatroom_channel';
import { addAttribute, populateList, disableEnterSubmit } from '../components/add_array_attributes';
import { alignSafariGridItems } from '../components/align_grid_items_on_safari';
import { autocompleteSearch } from '../components/autocomplete';
import { reloadWindowOnBackBtn } from '../components/back_btn_reload';
import { scrollOnArrows, hideArrowsOnScroll, changeImgDesktop, checkOnFilesState, switchImgWithDots, switchImgWithSwipe } from '../components/carousel';
import { attachCropperEvents } from '../components/cropper';
import { initFlatpickr } from '../components/datepicker';
import { deleteSoundcloudLinks } from '../components/delete_soundcloud_link';
import { renderDashboardDropdown } from '../components/dropdown_dashboard_menus';
import { renderPreview } from '../components/file_preview';
import { clickOnFilter } from '../components/filter_btn_covering_effect';
import { initGristackEdit, setSaveBtn } from '../components/gridstack_edit';
import { initGristackStatic } from '../components/gridstack_static';
import { highlight } from '../components/highlight_search_query';
import { initCursor } from '../components/homepage_cursor';
import { firstVisitCheck } from '../components/homepage_preloader';
import { homepageSlides } from '../components/homepage_slides';
import { listenCategories } from '../components/index_category_filter';
import { addNewMember } from '../components/new_member_form';
import { playFileOnClick } from '../components/play_audio_file';
import { listenSearchInput } from '../components/refresh_search';
import { fixBtnOnScroll } from '../components/save_display_btn';
import { xScrollOnArrows, hideArrowsOnXScroll, checkOnDashImgsState } from '../components/slider';
import { showSpinnerBtn } from '../components/spinner_btn';
import { setDropdown } from '../components/switch_payment_rate';
import { triggerTyped } from '../components/typed';

document.addEventListener('turbolinks:load', () => {
  if (document.querySelectorAll(".messages-js").length) {
    initChatroomCable();
  };
  if (document.querySelectorAll(".btn-add-attribute-js").length) {
    addAttribute();
    populateList();
    disableEnterSubmit();
  }
  if (document.querySelectorAll(".align-items-on-safari-js").length) {
    alignSafariGridItems();
  }
  if (document.querySelectorAll(".autocomplete-form-js").length) {
    autocompleteSearch();
  };
  if (document.querySelectorAll(".bck-btn-reload-js").length) {
    reloadWindowOnBackBtn();
  }
  if (document.querySelectorAll(".arrow-up-js").length ||
    document.querySelectorAll(".arrow-down-js").length) {
    scrollOnArrows();
  };
  if (document.querySelectorAll(".thumbnails-js").length) {
    switchImgWithDots();
    switchImgWithSwipe();
    hideArrowsOnScroll();
    checkOnFilesState();
  };
  if (document.querySelectorAll(".thumbnail-js").length) {
    changeImgDesktop();
  };
  if (document.querySelectorAll(".tag-cropper-js").length) {
    attachCropperEvents();
  }
  if (document.querySelectorAll(".datepicker-js").length) {
    initFlatpickr();
  };
  if (document.querySelectorAll(".soundcloud-link-js").length) {
    deleteSoundcloudLinks();
  }
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
  if (document.querySelectorAll(".gridstack-static-js").length) {
    initGristackStatic()
  }
  if (document.querySelectorAll(".highlight-js").length) {
    highlight();
  }
  if (document.querySelectorAll(".homepage-cursor-js").length) {
    initCursor();
  }
  if (document.querySelectorAll(".preloader-js").length) {
    firstVisitCheck();
  }
  if (document.querySelectorAll(".homepage-slides-js").length) {
    homepageSlides();
  }
  if (document.querySelectorAll(".checkbox-label-js").length) {
    listenCategories();
  }
  if (document.querySelectorAll(".btn-covering-js").length) {
    addNewMember();
  }
  if (document.querySelectorAll(".play-audio-js").length) {
    playFileOnClick();
  }
  if (document.querySelectorAll(".search-form-js").length) {
    listenSearchInput();
  };
  if (document.querySelectorAll(".save-display-btn-js").length) {
    fixBtnOnScroll();
  }
  if (document.querySelectorAll(".past-chevron-left-js").length) {
    xScrollOnArrows();
  };
  if (document.querySelectorAll(".slider-js").length) {
    hideArrowsOnXScroll();
    checkOnDashImgsState();
  };
  if (document.querySelectorAll(".form-btn-js").length) {
    showSpinnerBtn();
  }
  if (document.querySelectorAll(".dropdown-payment-js").length) {
    setDropdown();
  }
  if (document.querySelectorAll(".typed-js").length) {
    triggerTyped();
  }
});
