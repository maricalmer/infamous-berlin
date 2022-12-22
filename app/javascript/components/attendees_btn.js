const addAttendee = (event) => {
  event.currentTarget.lastElementChild.innerText = "Unattend";
}
const removeAttendee = () => {}

const triggerAttendBtn = () => {
  const attendBtn = document.querySelector(".attendees-btn-js")
  if (attendBtn.textContent.includes("Attend")) {
    attendBtn.addEventListener("click", addAttendee);
  } else {
    attendBtn.addEventListener("click", removeAttendee);
  }
}

export { triggerAttendBtn }
