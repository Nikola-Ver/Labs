window.onload = (e) => {
  document.getElementById("loader")?.remove();
};

const [login, password, repeatPassword] = document.getElementsByTagName(
  "input"
);

const [
  loginAfter,
  passwordAfter,
  repeatPasswordAfter,
] = document.getElementsByClassName("user-input");

login.onkeyup = () => {
  if (login.value.length > 0) {
    loginAfter.classList.add("active");
  } else {
    if (loginAfter.classList.contains("active"))
      loginAfter.classList.remove("active");
  }
};

password.onkeyup = () => {
  if (password.value.length > 0) {
    passwordAfter.classList.add("active");
  } else {
    if (passwordAfter.classList.contains("active"))
      passwordAfter.classList.remove("active");
  }
};

repeatPassword.onkeyup = () => {
  if (repeatPassword.value.length > 0) {
    if (password.value != repeatPassword.value) {
      repeatPassword.setCustomValidity("Passwords do not match");
    } else {
      repeatPassword.setCustomValidity("");
    }
    repeatPasswordAfter.classList.add("active");
  } else {
    if (repeatPasswordAfter.classList.contains("active"))
      repeatPasswordAfter.classList.remove("active");
  }
};

const changeToSignInButton = document.getElementById("change-to-signin");
const changeToSignUpButton = document.getElementById("change-to-signup");
const [mainForm] = document.getElementsByTagName("form");
const [headText] = document.getElementsByTagName("h1");
const root = document.getElementById("root");

changeToSignInButton.onclick = () => {
  mainForm.classList.add("signin");
  headText.textContent = "Sign in";
  if (root.classList.contains("hue-class")) root.classList.remove("hue-class");
};

changeToSignUpButton.onclick = () => {
  headText.textContent = "Sign up";
  if (mainForm.classList.contains("signin"))
    mainForm.classList.remove("signin");
  root.classList.add("hue-class");
};
