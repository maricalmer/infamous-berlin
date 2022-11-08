import 'gridstack/dist/gridstack.min.css';
import { GridStack } from 'gridstack';
import 'gridstack/dist/h5/gridstack-dd-native';

const initGristackEdit = () => {
  let grid = GridStack.init({
    minRow: 1
  });
}

const updateMirrorForm = () => {
  const mirrors = document.querySelectorAll(".mirror-js");
  mirrors.forEach((mirror) => {
    mirror.querySelector(".mirror-grid-x-js").value = mirror.attributes["gs-x"].nodeValue
    mirror.querySelector(".mirror-grid-y-js").value = mirror.attributes["gs-y"].nodeValue
    mirror.querySelector(".mirror-grid-h-js").value = mirror.attributes["gs-h"].nodeValue
    mirror.querySelector(".mirror-grid-w-js").value = mirror.attributes["gs-w"].nodeValue
  })
  triggerForms();
}

const setSaveBtn = () => {
  const btn = document.querySelector(".save-display-btn-js");
  btn.addEventListener("click", updateMirrorForm);
}

const pushUpdateToDB = (event) => {
  event.preventDefault()
  const url = event.target.action
  let mirror_form = event.target
  fetch(url, {
    method: "PATCH",
    headers: { "Accept": "text/plain" },
    body: new FormData(mirror_form)
  })
    .then(response => response.text())
    .then((data) => {
      mirror_form.outerHTML = data;
      // mirror_form = document.getElementById(mirror_form.id);
      // mirror_form.addEventListener("submit", pushUpdateToDB);
    })
}

const triggerForms = () => {
  const forms = document.querySelectorAll(".mirror-form-js")
  forms.forEach((form) => {
    form.addEventListener("submit", pushUpdateToDB)
    form.elements["submit-button"].click()
  })
}

export { initGristackEdit, setSaveBtn }
