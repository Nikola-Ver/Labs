function ClearTable() {
  const [myNode] = document.getElementsByClassName("Output");
  while (myNode.firstChild) {
    myNode.removeChild(myNode.firstChild);
  }
}

document.getElementsByClassName("but")[1].addEventListener("click", event => {
  const [div] = document.getElementsByClassName("Output");
  div.style.marginTop = "-100%";
  div.style.background = "rgba(255, 255, 255, 0)";
  div.style.transform = "rotate(-150deg)";
  div.style.marginLeft = "-100%";
  ClearTable();
});

let link = document.getElementById("load");
link.addEventListener("change", function() {
  let fr = new FileReader();
  fr.onload = function() {
    document.getElementsByClassName("Input")[0].value = this.result;
  };
  fr.readAsText(this.files[0]);
  link.value = null;
});

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

const operators = [
  "+",
  "-",
  "*",
  "/",
  "%",
  "**",
  "//",
  "if",
  "==",
  "!=",
  ">",
  "<",
  "<<",
  ">>",
  "<>",
  ">=",
  "<=",
  "&",
  "|",
  "^",
  "~",
  "or",
  "in",
  "and",
  "not",
  "is",
  "for",
  "while",
  "break",
  "continue"
];

const reservedWords = [
  "import",
  "else",
  "elif",
  "import",
  "def",
  "sys",
  "return",
  "random",
  "range"
];

// const start = event => {
//   findOperands(event.target.value);
// };

// document.querySelector("#text").addEventListener("input", start);

const result = code => {
  ClearTable();
  //=======================    Delete comments     ====================
  let _valideCode = code.replace(/""".*?"""/gis, "");
  _valideCode = _valideCode.replace(/#.*/gi, "");
  _valideCode = _valideCode.replace(/ +/g, " ");
  _valideCode = _valideCode.replace(/".*?"/gis, "");
  _valideCode = _valideCode.replace(/'.*?'/gis, "");
  _valideCode = _valideCode.replace(/true|false/gi, "");
  _valideCode = _valideCode.replace(/\'.*\'/gi, "");
  const _codeWithoutDEF = _valideCode.replace(/def.*/gi, "");
  _valideCode = _valideCode.replace(/def /gi, "");
  // let variablesArray = [];
  // [a-z][\w&]* *\(.*\) - для удаления функциональных переменнных, ах да, Андрей, сосат !!!
  //===================================================================
  // valideCode = valideCode.replace(/('[^']*')+/gi, "");
  // let operandsArray = valideCode.match(/('[^']*')+/gi) || [];
  // TODO: 4 регулярки
  // 1: Все переменные
  // 2: Переменные после while for if elif andrew
  // 3: Переменные, которые вводятся kolya +
  // 4: Переменные, которые справа от `=` (?) kolya +
  // 5: остальные: мусорные

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++
  //    ▬▬.◙.▬▬▬
  //   ▂▄▄▓▄▄▂
  // ◢◤ █▀▀████▄▄▄▄◢◤
  // █▄ █ █▄ ███▀▀▀▀▀▀▀╬P
  let forPrintVariables = _valideCode;
  let inputValues = _valideCode.match(/.*(?= *\= *input\(.*\))/gi);
  if (inputValues) {
    inputValues = inputValues.join(" ");
    inputValues = inputValues.match(/[a-z][\w$]*/gi);
  }
  let allVariables;
  if (_valideCode)
    allVariables = _valideCode.match(
      /[a-z][a-z0-9_$]*(?=(\[| |$|\)|,|\]|:))/gi
    );

  if (allVariables)
    allVariables = allVariables.filter(
      word => !reservedWords.includes(word) && !operators.includes(word)
    );
  console.log("allVariables", allVariables);
  _valideCode = _valideCode.replace(/.*input.*/gi, "");

  _valideCode = _valideCode.replace(/[a-z][\w$]* *\(/gi, "");
  let leftBeforeEquallyValues = [];
  let rightAfterEquallyValues = [];
  let validCodeTemp = _valideCode;

  // Удалить все функции и функциональные переменные!!!

  leftBeforeEquallyValues = validCodeTemp.match(/(.*)(?=(\=))/gi);
  if (leftBeforeEquallyValues) {
    leftBeforeEquallyValues = leftBeforeEquallyValues.map(element =>
      element.trim()
    );
    leftBeforeEquallyValues = leftBeforeEquallyValues.join(" ");
    leftBeforeEquallyValues = leftBeforeEquallyValues.match(/[a-z][\w$]*/gi);
  }
  leftBeforeEquallyValues = leftBeforeEquallyValues
    ? leftBeforeEquallyValues
    : [];
  rightAfterEquallyValues = validCodeTemp.match(/(?<=(\=))(.*)/gi);
  if (rightAfterEquallyValues) {
    rightAfterEquallyValues = rightAfterEquallyValues.map(element =>
      element.trim()
    );
    rightAfterEquallyValues = rightAfterEquallyValues.join(" ");
    rightAfterEquallyValues = rightAfterEquallyValues.match(/[a-z][\w$]*/gi);
  }

  //    ▬▬.◙.▬▬▬
  //   ▂▄▄▓▄▄▂
  // ◢◤ █▀▀████▄▄▄▄◢◤
  // █▄ █ █▄ ███▀▀▀▀▀▀▀╬
  // ◥█████◤
  // ══╩══╩═
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++
  //============================================================
  let conditionStrings;
  const mapVariables = new Map();
  if (_valideCode)
    conditionStrings = _valideCode.match(
      /((?<=\bif\b)|(?<=\bwhile\b)|(?<=\bfor\b)|(?<=\belif\b)).*/gi
    );

  allVariables = allVariables ? allVariables : [];
  allVariables.forEach(elem => {
    if (mapVariables.has(elem))
      mapVariables.set(elem, mapVariables.get(elem) + 1);
    else mapVariables.set(elem, 1);
  });

  let MVal = new Set();
  mapVariables.forEach((val, key) => {
    if (val > 1) MVal.add(key);
  });

  console.log(MVal);

  let C; //DONE

  if (conditionStrings) {
    C = (conditionStrings.join(" ").match(/[a-z][a-z0-9_$]*/gi) || []).filter(
      word => !reservedWords.includes(word) && !operators.includes(word)
    );
  } else C = [];

  let functionValues =
    (_codeWithoutDEF.match(/(?<=\()([^\(\)])*(\s|\))(?!\()/gi) || [])
      .join(" ")
      .replace(")", "")
      .match(/[a-z][\w$]*/gi) || [];

  let P = inputValues //DONE
    ? inputValues.filter(
        elem => !leftBeforeEquallyValues.includes(elem) && !C.includes(elem)
      )
    : [];

  MVal = [...MVal];
  console.log(MVal);
  let M = (allVariables || [])
    .concat(functionValues)
    .concat(_valideCode.match(/(?<=\[)[a-z][\w$]*/gi) || [])
    .filter(
      elem =>
        !C.includes(elem) &&
        !reservedWords.includes(elem) &&
        !operators.includes(elem) &&
        MVal.includes(elem)
    );
  console.log(M);

  let T = allVariables.filter(
    elem => !C.includes(elem) && !M.includes(elem) && !P.includes(elem)
  );

  const allSets = new Set(
    M.concat(T)
      .concat(P)
      .concat(C)
  );

  const P_MAP = new Map();

  const ALL_P = allVariables.filter(e => P.includes(e));
  console.log("ALL_P", ALL_P, "allVariables", allVariables);
  ALL_P.forEach(e => {
    if (P_MAP.has(e)) {
      P_MAP.set(e, P_MAP.get(e) + 1);
    } else {
      P_MAP.set(e, 1);
    }
  });

  console.log("P", P);
  M = new Set(M);
  T = new Set(T);
  P = new Set(P);
  C = new Set(C);
  console.log(P_MAP);
  P_MAP.forEach((value, key) => {
    if (value === 1) T.add(key);
  });

  console.log("M", M, "T", T, "P", P, "C", C);
  console.log();
  // console.log("C", C);
  // console.log("P", P);
  // console.log("T", T);
  // console.log(allSets);

  // console.log("spen", mapVariables);

  //mapVariables === СПЕН (НО НАДО ОТНЯТЬ ЕДИНИЦУ)

  //============================================================
  // ░░░░░░███████ ]▄▄▄▄▄▄▄▄▃
  // ▂▄▅██████████▅▄▃▂
  // I███████████████████].
  // ◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤...

  // ░░░░░░███████ ]▄▄▄▄▄▄▄▄▃
  // ▂▄▅██████████▅▄▃▂
  // I███████████████████].
  // ◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤...

  //   ░░░░░░███████ ]▄▄▄▄▄▄▄▄▃
  // ▂▄▅██████████▅▄▃▂
  // I███████████████████].
  // ◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤...
  let printVariables =
    (forPrintVariables.match(/(?<=print)[^\w].*/gi) || [])
      .join(" ")
      .replace(/[a-z][\w$]* *\(/gi, "")
      .match(/[a-z][\w$]*/gi) || [];

  const setPrintVariables = [...new Set(printVariables)];

  const setInputVariables = [...new Set(inputValues)];

  let M_Table2 = new Set();
  let C_Table2 = new Set();
  let P_Table2 = new Set();
  let T_Table2 = new Set();

  setInputVariables.forEach(e => {
    if (M.has(e)) M_Table2.add(e);
    if (C.has(e)) C_Table2.add(e);
    if (P.has(e)) P_Table2.add(e);
    if (T.has(e)) T_Table2.add(e);
  });

  setPrintVariables.forEach(e => {
    if (M.has(e)) M_Table2.add(e);
    if (C.has(e)) C_Table2.add(e);
    if (P.has(e)) P_Table2.add(e);
    if (T.has(e)) T_Table2.add(e);
  });
  // console.log(M_Table2, P_Table2, C_Table2, T_Table2);
  // const reg = /[a-z][a-z0-9_$]*(?=(\[| |$|\)|,|\]|:))/gi
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //   ░░░░░░███████ ]▄▄▄▄▄▄▄▄▃                ---0
  // ▂▄▅██████████▅▄▃▂
  // I███████████████████].
  // ◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤...
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  let Output = document.getElementsByClassName("Output")[0];

  Output.style.marginTop = "-0.5%";
  Output.style.background = "rgb(200,200,200)";
  Output.style.transform = "rotate(0deg)";
  Output.style.marginLeft = "27.6%";

  let intoDiv = document.getElementsByClassName("Output")[0];
  let div = document.createElement("p");

  div.className = "headText";
  div.textContent = "Спен программы";
  intoDiv.appendChild(div);
  div = document.createElement("table");
  div.className = "tableStyle";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("table")[0];
  div = document.createElement("tbody");
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tbody")[0];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tr")[0];
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Индентификатор";
  intoDiv.appendChild(div);
  mapVariables.forEach((val, key) => {
    div = document.createElement("th");
    div.className = "cellStyle";
    div.textContent = String(key);
    intoDiv.appendChild(div);
  });
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Суммарный спен программы";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tbody")[0];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = div;
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Спен";
  intoDiv.appendChild(div);
  let Sum = 0;
  mapVariables.forEach((val, key) => {
    div = document.createElement("th");
    div.className = "cellStyle";
    div.textContent = String(val - 1);
    intoDiv.appendChild(div);
    Sum += val - 1;
  });
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = String(Sum);
  intoDiv.appendChild(div);

  intoDiv = document.getElementsByClassName("Output")[0];
  div = document.createElement("p");
  div.className = "head4ap";
  div.textContent = "Метрика Чепина программы";
  intoDiv.appendChild(div);
  div = document.createElement("table");
  div.className = "tableStyle";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("table")[1];
  div = document.createElement("tbody");
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tbody")[1];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tr")[2];
  div = document.createElement("th");
  div.className = "cellStyle";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.colSpan = "4";
  div.className = "cellStyle";
  div.textContent = "Полная метрика Чепина";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.colSpan = "4";
  div.className = "cellStyle";
  div.textContent = "Метрика Чепина ввода/вывода";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tbody")[1];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = div;
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Группа переменных";
  intoDiv.appendChild(div);
  for (let d = 0; d < 2; d++) {
    div = document.createElement("th");
    div.className = "cellStyle";
    div.textContent = "P";
    intoDiv.appendChild(div);
    div = document.createElement("th");
    div.className = "cellStyle";
    div.textContent = "M";
    intoDiv.appendChild(div);
    div = document.createElement("th");
    div.className = "cellStyle";
    div.textContent = "C";
    intoDiv.appendChild(div);
    div = document.createElement("th");
    div.className = "cellStyle";
    div.textContent = "T";
    intoDiv.appendChild(div);
  }
  intoDiv = document.getElementsByTagName("tbody")[1];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = div;
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Переменные относящиеся к группе";
  intoDiv.appendChild(div);
  let str = "";
  P.forEach((val, key) => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  M.forEach((val, key) => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  C.forEach((val, key) => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  T.forEach((val, key) => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  P_Table2.forEach(key => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  M_Table2.forEach(key => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  C_Table2.forEach(key => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  str = "";
  T_Table2.forEach(key => {
    str += key + ", ";
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = str;
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tbody")[1];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = div;
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Количество переменных в группе";
  intoDiv.appendChild(div);

  let p1 = 0;
  P.forEach((val, key) => {
    ++p1;
  });
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "p = " + String(p1);
  intoDiv.appendChild(div);
  let m1 = 0;
  M.forEach((val, key) => {
    ++m1;
  });
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "m = " + String(m1);
  intoDiv.appendChild(div);
  let c1 = 0;
  C.forEach((val, key) => {
    ++c1;
  });
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "c = " + String(c1);
  intoDiv.appendChild(div);
  let t1 = 0;
  T.forEach((val, key) => {
    ++t1;
  });
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "t = " + String(t1);
  intoDiv.appendChild(div);
  let p2 = 0;
  P_Table2.forEach(key => {
    ++p2;
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = String(p2);
  intoDiv.appendChild(div);
  let m2 = 0;
  M_Table2.forEach(key => {
    ++m2;
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = String(m2);
  intoDiv.appendChild(div);
  let c2 = 0;
  C_Table2.forEach(key => {
    ++c2;
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = String(c2);
  intoDiv.appendChild(div);
  let t2 = 0;
  T_Table2.forEach(key => {
    ++t2;
  });
  str = str.slice(0, str.length - 2);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = String(t2);
  intoDiv.appendChild(div);

  intoDiv = document.getElementsByTagName("tbody")[1];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = div;
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Метрика Чепина";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.colSpan = "4";
  div.textContent =
    "Q = 1 * " +
    String(p1) +
    " + " +
    "2 * " +
    String(m1) +
    " + " +
    "3 * " +
    String(c1) +
    " + " +
    "0.5 * " +
    String(t1) +
    " + " +
    " = " +
    String(p1 + 2 * m1 + 3 * c1 + 0.5 * t1);
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.colSpan = "4";
  div.textContent =
    "Q = 1 * " +
    String(p2) +
    " + " +
    "2 * " +
    String(m2) +
    " + " +
    "3 * " +
    String(c2) +
    " + " +
    "0.5 * " +
    String(t2) +
    " + " +
    " = " +
    String(p2 + 2 * m2 + 3 * c2 + 0.5 * t2);
  intoDiv.appendChild(div);
};
