const setDropdown = () => {
  const dropdown = document.querySelector(".dropdown-payment-js");
  dropdown.addEventListener("change", function() {
    const text = document.querySelector(".job-payment-js");
    if (dropdown.options[dropdown.selectedIndex].value === "hourly_rate") {
      text.innerHTML = "€ per hour"
    } else {
      text.innerHTML = "€ total"
    }
  })
}

export { setDropdown }
