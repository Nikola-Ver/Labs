document.getElementsByClassName('Input')[0].addEventListener("mouseup", InputArea);
let flag = false; 

function InputArea() {
  if (flag) document.getElementsByClassName('TableArea')[0].style.width = 
      String(1650 - Number(document.getElementsByClassName('Input')[0].style.width.match(/[0-9]*/).join(""))) + "px";
};

function ResultBut() {
  ClearTable();
  document.getElementsByClassName('TableArea')[0].style.width = 
    String(1650 - Number(document.getElementsByClassName('Input')[0].style.width.match(/[0-9]*/).join(""))) + "px";
  findOperands(document.querySelector("#text").value);
  document.getElementsByClassName('TableArea')[0].style.background = "white";
  flag = true; 
};

function CloseBut() {
  document.getElementsByClassName('TableArea')[0].style.width = "0"; 
  document.getElementsByClassName('TableArea')[0].style.background = "transparent";
  ClearTable();
  flag = false;
};

function ClearTable() {
  let temp = document.getElementsByClassName("tableStyle")[0];
  if (temp != null) temp.remove();
  for (let i = 0; i < 3; i++)
  {
    temp = document.getElementsByClassName("FinalOutput")[0];
    if (temp != null) temp.remove();
  };
};

function CreaTable(OpertorsArr, OperandsArr, dictionary, len, volume) {
  ClearTable();
//------------------------Заголовок-----------------------------//
  let intoDiv = document.getElementsByClassName("TableArea")[0];
  let div = document.createElement("table");
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
  div.textContent = "j";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Оператор";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "f";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("th")[2];
  div = document.createElement("sub");
  div.textContent = "1j";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("tr")[0];
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "i"
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "Операнд";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyle";
  div.textContent = "f";
  intoDiv.appendChild(div);
  intoDiv = document.getElementsByTagName("th")[5];
  div = document.createElement("sub");
  div.textContent = "2i";
  intoDiv.appendChild(div);
//--------------------------------------------------------------//
  let j = 1;
  console.log(OpertorsArr.index);
  for (let keyOperators of OpertorsArr.keys())
  {
    intoDiv = document.getElementsByTagName("tbody")[0];
    div = document.createElement("tr");
    intoDiv.appendChild(div);
    intoDiv = document.getElementsByTagName("tr")[j];
    div = document.createElement("td");
    div.className = "cellStyle";
    div.textContent = String(j) + ".";
    intoDiv.appendChild(div);
    div = document.createElement("td");
    div.className = "cellStyle";
    div.textContent = String(keyOperators);
    intoDiv.appendChild(div);
    j++;
  };

  j = 1;
  let OpertorsSum = 0;
  for (let valOperators of OpertorsArr.values())
  {
    intoDiv = document.getElementsByTagName("tr")[j];
    div = document.createElement("td");
    div.className = "cellStyle";
    div.textContent = String(valOperators);
    intoDiv.appendChild(div);
    OpertorsSum += valOperators;
    j++;
  };

  let i = 1;
  for (let keyOperands of OperandsArr.keys())
  {
    intoDiv = document.getElementsByTagName("tr")[i];
    console.log(intoDiv);
    if (intoDiv === undefined)
    {
      intoDiv = document.getElementsByTagName("tbody")[0];
      div = document.createElement("tr");
      intoDiv.appendChild(div);
      intoDiv = document.getElementsByTagName("tr")[i];
      for (let d = 0; d < 3; d++) 
      {
        div = document.createElement("td");
        div.className = "cellStyle";
        intoDiv.appendChild(div);
      }
    };
    div = document.createElement("td");
    div.className = "cellStyle";
    div.textContent = String(i) + ".";
    intoDiv.appendChild(div);
    div = document.createElement("td");
    div.className = "cellStyle";
    div.textContent = String(keyOperands);
    intoDiv.appendChild(div);
    i++;
  };

  i = 1;
  let OperandsSum = 0;
  for (let valOperands of OperandsArr.values())
  {
    intoDiv = document.getElementsByTagName("tr")[i];
    div = document.createElement("td");
    div.className = "cellStyle";
    div.textContent = String(valOperands);
    intoDiv.appendChild(div);
    OperandsSum += valOperands;
    i++;
  };

  if (i - j < 0) 
    for (let d = i; d < j; d++)
    {
      intoDiv = document.getElementsByTagName("tr")[d];
      for (let k = 0; k < 3; k++)
      {
        div = document.createElement("td");
        div.className = "cellStyle";
        intoDiv.appendChild(div);
      };
    };
  
  intoDiv = document.getElementsByTagName("tbody")[0];
  div = document.createElement("tr");
  intoDiv.appendChild(div);
  intoDiv = div;
  div = document.createElement("th");
  div.textContent = "η1 = " + String(j - 1);
  div.className = "cellStyleKPD";
  intoDiv.appendChild(div);
  div = document.createElement("td");
  div.className = "cellStyle";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyleKPD";
  div.textContent = "N1 = " + String(OpertorsSum);
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.textContent = "η2 = " + String(i - 1);
  div.className = "cellStyleKPD";
  intoDiv.appendChild(div);
  div = document.createElement("td");
  div.className = "cellStyle";
  intoDiv.appendChild(div);
  div = document.createElement("th");
  div.className = "cellStyleKPD";
  div.textContent = "N2 = " + String(OperandsSum);
  intoDiv.appendChild(div);

  intoDiv = document.getElementsByClassName("TableArea")[0];
  div = document.createElement("p");
  div.className = "FinalOutput"
  div.textContent = "Словарь программы η = " + String(j - 1) + " + " + String(i - 1) + " = " + String(dictionary);
  intoDiv.appendChild(div);
  div = document.createElement("p");
  div.className = "FinalOutput"
  div.textContent = "Длина программы N = " + String(OpertorsSum) + " + " + String(OperandsSum) + " = " + String(len);
  intoDiv.appendChild(div);
  div = document.createElement("p");
  div.className = "FinalOutput"
  div.textContent = "Объем программы N = " + String(len) + " log2 " + String(dictionary) + " = " + String(Math.ceil(volume));
  intoDiv.appendChild(div);
};

function LoadBut() {
  document.getElementsByClassName("load")[0].click();
};

document.getElementsByClassName("load")[0].addEventListener('change', function(){
  var fr = new FileReader();
  fr.onload = function() {
    document.getElementsByClassName('Input')[0].value = this.result;
};
fr.readAsText(this.files[0]);
});

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
  "<>",
  ">",
  "<",
  ">=",
  "<=",
  "&",
  "|",
  "^",
  "~",
  "<<",
  ">>",
  "or",
  "in",
  "and",
  "not",
  "is",
  "for",
  "while",
  "break",
  "continue",
];
const reservedWords = ["import", "else", "elif", "import", "def", "sys", "return", "random"];
const findOperands = code => {
  const operandsMap = new Map();
  const functionsMap = new Map();
  let valideCode = code.replace(/""".*?"""/gis, "");
  valideCode = valideCode.replace(/#.*/gi, "");
  let functionsArray = [];
  valideCode = valideCode.replace(/def .*/gi, "");
  valideCode = valideCode.replace(/ +/g, " ");
  console.log(valideCode);

  let operandsArray = valideCode.match(/('[^']*')+/gi) || [];
  valideCode = valideCode.replace(/('[^']*')+/gi, "");

  functionsArray.push(valideCode.match(
    /([a-z]([a-z0-9_$]+\.?)+(?=\())|if|==|!=|-=|\+=|<>|>=|<=|&|\||\^|~|<<|>>|>|<|\+|\-|=|\*|\/|%|\*\*|\/\/| or | in | and | not | is | for | while | break | continue |(?<!([a-zа-яё]+ *))\(/gi,
  ));
  console.log(functionsArray);
  functionsArray = functionsArray.flat(1);
  console.log(functionsArray);
  operandsArray = operandsArray.concat(valideCode.match(/(?<!\\)(([a-z0-9][a-z0-9_$]*)+\.?)+/gi));

  if (functionsArray[0] === null) 
  {
    let intoDiv = document.getElementsByClassName("TableArea")[0];
    let p = document.createElement("p");
    p.className = "FinalOutput";
    p.textContent = "Для того чтобы получить результат, введите код программы на Python";
    intoDiv.appendChild(p);
    return;
  };

  functionsArray.forEach(elem => {
    if (elem === "(") elem = "( )";
    if (functionsMap.has(elem)) {
      functionsMap.set(elem, functionsMap.get(elem) + 1);
    } else {
      functionsMap.set(elem, 1);
    }
  });
  console.log("funcMap: ", functionsMap);
  operandsArray.forEach(elem => {
    if (operandsMap.has(elem)) {
      operandsMap.set(elem, operandsMap.get(elem) + 1);
    } else {
      operandsMap.set(elem, 1);
    }
  });
  for (let [key] of operandsMap) {
    if (functionsMap.has(key) || operators.includes(key) || reservedWords.includes(key)) {
      operandsMap.delete(key);
    }
  }
  console.log("operandsMap: ", operandsMap);
  const словарьПрограммы = operandsMap.size + functionsMap.size;
  let длиннаПрограммы = 0;
  for (let [key] of operandsMap) {
    длиннаПрограммы += operandsMap.get(key);
  }
  for (let [key] of functionsMap) {
    длиннаПрограммы += functionsMap.get(key);
  }
  const объемПрограммы = длиннаПрограммы * Math.log2(словарьПрограммы);
  console.log(словарьПрограммы, длиннаПрограммы, объемПрограммы);

  CreaTable(functionsMap, operandsMap, словарьПрограммы, длиннаПрограммы, объемПрограммы);
};