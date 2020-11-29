let prevElem = null;
window.addEventListener("touchstart", (e) => {
  const hoverClasses = ["control-buttons"];
  const classHover = "hover";

  if (prevElem) {
    prevElem.classList.remove(classHover);
    prevElem = null;
  }

  e.path.forEach((ePath) => {
    hoverClasses.forEach((eHoverClasses) => {
      if (ePath.classList?.contains(eHoverClasses)) {
        ePath.classList.add(classHover);
        prevElem = ePath;
      }
    });
  });
});

let page = 2;
const [mainDiv] = document.getElementsByTagName("main");
mainDiv.scrollTo(2 * window.innerWidth, 0);

mainDiv.onscroll = (e) => {
  const newPage = Math.round(mainDiv.scrollLeft / window.innerWidth);
  if (page !== newPage)
    document.documentElement.style.setProperty("--current-page", newPage);
  page = newPage;
};

function changePage(newPage, element) {
  page = newPage;
  document.documentElement.style.setProperty("--current-page", newPage);
  try {
    element.scrollIntoView();
  } catch {}
  mainDiv.scrollTo(page * window.innerWidth, 0);
}

const teacherDropDownBox = document.getElementById("teacher-drop-down-box");
const studentDropDownBox = document.getElementById("student-drop-down-box");
const aboutDropDownBox = document.getElementById("about-drop-down-box");

teacherDropDownBox.onclick = (e) => {
  document.getElementById("teacher-content").childNodes.forEach((element) => {
    if ("teacher-" + e.target.textContent.trim().toLowerCase() === element.id)
      changePage(0, element);
  });
};

studentDropDownBox.onclick = (e) => {
  document.getElementById("student-content").childNodes.forEach((element) => {
    if ("student-" + e.target.textContent.trim().toLowerCase() === element.id)
      changePage(1, element);
  });
};

aboutDropDownBox.onclick = (e) => {
  document.getElementById("about-content").childNodes.forEach((element) => {
    if ("about-" + e.target.textContent.trim().toLowerCase() === element.id)
      changePage(2, element);
  });
};

window.onload = (e) => {
  document.getElementById("loader")?.remove();
};
