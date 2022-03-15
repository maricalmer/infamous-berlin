const setDropdown = () => {
  const dropdown = document.querySelector(".dropdown-payment-js");
  dropdown.addEventListener("change", function() {
    console.log("callback")
    const text = document.querySelector(".job-payment-js");
    if (dropdown.options[dropdown.selectedIndex].value === "hourly rate") {
      text.innerHTML = "€ per hour"
    } else {
      text.innerHTML = "€ total"
    }
  })
}

export { setDropdown }
