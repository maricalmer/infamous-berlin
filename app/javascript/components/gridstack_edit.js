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
    mirror.firstElementChild.firstElementChild.children[2].children[2].children["mirror_grid_x"].value = mirror.attributes["gs-x"].nodeValue
    mirror.firstElementChild.firstElementChild.children[2].children[3].children["mirror_grid_y"].value = mirror.attributes["gs-y"].nodeValue
    mirror.firstElementChild.firstElementChild.children[2].children[4].children["mirror_grid_h"].value = mirror.attributes["gs-h"].nodeValue
    mirror.firstElementChild.firstElementChild.children[2].children[5].children["mirror_grid_w"].value = mirror.attributes["gs-w"].nodeValue
  })
  triggerForms();
}

const setSaveBtn = () => {
  const btn = document.querySelector(".save-display-btn-js");
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
    form.elements["submit-button"].click()
  })
}

export { initGristackEdit, setSaveBtn }
