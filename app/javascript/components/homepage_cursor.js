const initCursor = () => {
  let clientX = -100;
  let clientY = -100;
  const innerCursor = document.querySelector(".homepage-cursor-js");
  document.addEventListener("mousemove", e => {
    clientX = e.clientX;
    clientY = e.clientY;
  });
  const render = () => {
    innerCursor.style.transform = `translate(${clientX}px, ${clientY}px)`;
    requestAnimationFrame(render);
  };
  requestAnimationFrame(render);
};

export { initCursor }
