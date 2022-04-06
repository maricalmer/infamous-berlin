import 'gridstack/dist/gridstack.min.css';
import { GridStack } from 'gridstack';
import 'gridstack/dist/h5/gridstack-dd-native';

const saveGrid = () => {
  const grid = document.querySelector(".grid-stack");
  const serializedData = grid.gridstack.save(true, true);
  console.log(serializedData);
  localStorage.setItem("savedGrid", JSON.stringify(serializedData, null, '  '));
}

const initGristack = () => {
  const savedVersion = localStorage.getItem('savedGrid');
  console.log("savedVersion:")
  if (savedVersion == null) {
    console.log("no saved version")
    let grid = GridStack.init({
      minRow: 1
    });
  } else {
    let grid = GridStack.init({
      minRow: 1
    });
    const parsed_json = JSON.parse(savedVersion).children
    const nodes = document.querySelectorAll(".grid-stack-item")
    console.log("nodes:")
    console.log(nodes)
    console.log("JSON:")
    console.log(parsed_json)
    for (let i = 0; i < nodes.length; i++) {
      nodes[i].attributes["gs-x"].value = parsed_json[i].x
      nodes[i].attributes["gs-y"].value = parsed_json[i].y
      nodes[i].attributes["gs-w"].value = parsed_json[i].w
      nodes[i].attributes["gs-h"].value = parsed_json[i].h
    }
  }
}

const setSaveBtn = () => {
  const btn = document.querySelector(".gridstack-save-btn-js");
  btn.addEventListener("click", saveGrid);
}

// const saveTestGrid = () => {
//   const grid = document.querySelector(".grid-stack");
//   grid.addEventListener("change", function (event, el) {
//     var serializedFull = grid.gridstack.save(true, true);
//     var serializedData = serializedFull.children;
//     console.log(serializedFull);
//     console.log(serializedData);
//   });
// }

export { initGristack, setSaveBtn }
