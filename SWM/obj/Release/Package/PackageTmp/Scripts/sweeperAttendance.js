const dropdownBtn = document.querySelectorAll(".dropdown-btn");

dropdownBtn.forEach((btn) => {
  const icon = btn.querySelector('.toggler');
  const dropdownContent = btn.nextElementSibling;
  btn.addEventListener("click", () => {
    dropdownContent.classList.toggle("active");
    icon.classList.toggle('active');
  });
});

const dateInput = document.querySelectorAll('.filters .date-wrapper input');
const currentDate = new Date().toISOString().substr(0, 10);

dateInput.forEach(input => {
    input.value = currentDate;
});


