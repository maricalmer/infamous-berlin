import Typed from 'typed.js';

const triggerTyped = () => {
  const options = {
    stringsElement: '.footer-message-dynamic-strings-js',
    typeSpeed: 150,
    loop: true,
    loopCount: Infinity,
    showCursor: false,
  };
  const typed = new Typed('.typed-js', options);
}

export { triggerTyped }
