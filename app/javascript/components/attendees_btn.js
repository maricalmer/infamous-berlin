const addAttendee = (event) => {
  event.currentTarget.firstElementChild.classList.remove("fa-user-plus")
  event.currentTarget.firstElementChild.classList.remove("event-title-and-details__attendees-plus-icon")
  event.currentTarget.firstElementChild.classList.add("fa-user-minus")
  event.currentTarget.firstElementChild.classList.add("event-title-and-details__attendees-minus-icon")
  event.currentTarget.removeEventListener("click", addAttendee);
  event.currentTarget.addEventListener("click", removeAttendee);
}
const removeAttendee = (event) => {
  event.currentTarget.firstElementChild.classList.remove("fa-user-minus")
  event.currentTarget.firstElementChild.classList.remove("event-title-and-details__attendees-minus-icon")
  event.currentTarget.firstElementChild.classList.add("fa-user-plus")
  event.currentTarget.firstElementChild.classList.add("event-title-and-details__attendees-plus-icon")
  event.currentTarget.removeEventListener("click", removeAttendee);
  event.currentTarget.addEventListener("click", addAttendee);
}

const triggerAttendBtn = () => {
  const attendBtn = document.querySelector(".attendees-btn-js")
  if (attendBtn.innerHTML.includes("Attend")) {
    attendBtn.addEventListener("click", addAttendee);
  } else {
    attendBtn.addEventListener("click", removeAttendee);
  }
}

export { triggerAttendBtn }
