import 'gridstack/dist/gridstack.min.css';
import { GridStack } from 'gridstack';
import 'gridstack/dist/h5/gridstack-dd-native';

const initGristack = () => {
  let grid = GridStack.init({
    minRow: 1
  });
}

const updateMirrorForm = () => {
  const mirrors = document.querySelectorAll(".mirror-js");
  mirrors.forEach((mirror) => {
    mirror.firstElementChild.firstElementChild.lastElementChild.previousElementSibling.previousElementSibling[2].value = mirror.attributes["gs-x"].nodeValue
    mirror.firstElementChild.firstElementChild.lastElementChild.previousElementSibling.previousElementSibling[3].value = mirror.attributes["gs-y"].nodeValue
    mirror.firstElementChild.firstElementChild.lastElementChild.previousElementSibling.previousElementSibling[4].value = mirror.attributes["gs-h"].nodeValue
    mirror.firstElementChild.firstElementChild.lastElementChild.previousElementSibling.previousElementSibling[5].value = mirror.attributes["gs-w"].nodeValue
  })
  triggerForms();
}

const setSaveBtn = () => {
  const btn = document.querySelector(".gridstack-save-btn-js");
  btn.addEventListener("click", updateMirrorForm);
}

const pushUpdate = (event) => {
  event.preventDefault()
  const url = event.target.action
  let mirror_form = event.target
  fetch(url, {
    method: "PATCH",
    headers: { "Accept": "text/plain" },
    body: new FormData(event.target)
  })
    .then(response => response.text())
    .then((data) => {
      mirror_form.outerHTML = data;
      mirror_form = document.getElementById(mirror_form.id);
      mirror_form.addEventListener("submit", pushUpdate);
    })
}

const triggerForms = () => {
  const forms = document.querySelectorAll(".mirror-form-js")
  forms.forEach((form) => {
    form.addEventListener("submit", pushUpdate)
    form.elements[7].click()
    // ^^ submit btn
  })
}

export { initGristack, setSaveBtn }
