// import 'gridstack/dist/gridstack.min.css';
import { GridStack } from 'gridstack';

const initGristackStatic = () => {
  let grid = GridStack.init({
    staticGrid: true
  });
}

export { initGristackStatic }
