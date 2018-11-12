var regpassword = document.getElementById("regpassword"),
confirm_password = document.getElementById("confirm_password");

var email = document.getElementById("email");

var regsubmit = document.getElementById("regsubmit");


function validatePassword() {
  if (regpassword.value != confirm_password.value) {
      confirm_password.setCustomValidity("Hasła nie są identyczne");
  } else {
      confirm_password.setCustomValidity("");
  }
}

function validateEmail() {
  if (email.value.includes("@")) {
    email.setCustomValidity("");
  } else {
    email.setCustomValidity("Email nieprawidłowy");
  }
}

regpassword.addEventListener("change", validatePassword);
confirm_password.addEventListener("keyup", validatePassword);

email.addEventListener("keyup", validateEmail);