let state;
let resultFile;
let fileName;
let ProcFlag = false;

const calculateY = (g, x, p) => PowerOnMod(g, x, p);

const calculateA = (g, k, p) => PowerOnMod(g, k, p);

const calculateB = (p, k, M, Y) => (PowerOnMod(Y, k, p) * M) % p;

const encrypt = (x, p, g, k, dataArray) => {
  const A = calculateA(g, k, p);
  const Y = calculateY(g, x, p);
  return dataArray
    .map(M => {
      const B = calculateB(p, k, M, Y);
      return [A, B];
    })
    .flat(1);
};

const decrypt = (x, p, dataArray) => {
  const length = dataArray.length;
  const result = [];

  for (let i = 0; i < length; i += 2) {
    const A = dataArray[0 + i];
    const B = dataArray[1 + i];
    const M = (B * PowerOnMod(A, p - 1 - x, p)) % p;
    result.push(M);
  }
  return result;
};

document.body.ondragover = function(event) {
  document.getElementsByClassName("input")[0].value =
    "\n\n\n\n\n\n\n\n\n\n\n\n\n                     Отпустите файл чтобы считать текст";
  document.getElementsByClassName("input")[0].removeAttribute("style");
};

document.body.ondragleave = function(event) {
  document.getElementsByClassName("input")[0].removeAttribute("style");
  document.getElementsByClassName("input")[0].value = "";
};

function Download() {
  const a = document.getElementById("download");
  const blob = new Blob([resultFile], { type: "octet/stream" });
  const url = window.URL.createObjectURL(blob);
  a.href = url;
  a.download = `${fileName}`;
  a.click();
  window.URL.revokeObjectURL(url);
}

function decryptBeg() {
  let [val] = document.getElementsByClassName("gBox");
  val.style.marginLeft = "-40%";
  val.style.opacity = "0";
  document.getElementsByClassName("butLoad")[0].click();
}

function encryptBeg() {
  let [val] = document.getElementsByClassName("gBox");
  val.style.marginLeft = "-40%";
  val.style.opacity = "0";
  document.getElementsByClassName("butLoad")[0].click();
}

document
  .getElementsByClassName("butLoad")[0]
  .addEventListener("change", event => {
    const file = event.target.files[0];
    const reader = new FileReader();
    fileName = file.name;

    reader.onload = event => {
      let arrInt;
      resultFile = null;
      if (state) {
        arrInt = [...new Uint8Array(event.target.result)];
      } else {
        arrInt = [...new Uint16Array(event.target.result)];
      }
      document.getElementsByClassName("input")[0].value = arrInt;

      const x = Number(document.getElementsByClassName("value")[2].value);
      const p = Number(document.getElementsByClassName("value")[0].value);
      const g = Number(document.getElementById("g").value);
      const k = Number(document.getElementsByClassName("value")[1].value);
      let data;
      if (state) data = encrypt(x, p, g, k, arrInt);
      else data = decrypt(x, p, arrInt);
      if (state) {
        resultFile = new Uint16Array(data);
      } else {
        resultFile = new Uint8Array(data);
      }
      document.getElementsByClassName("output")[0].innerText = resultFile;
      ProcFlag = false;
    };
    reader.readAsArrayBuffer(file);
  });

function decryptBut() {
  if (ProcFlag) return;
  state = false;
  let val = document.getElementsByClassName("inputKeys")[0].style;
  val.marginTop = "20%";
  val.opacity = "1";
  val = document.getElementsByClassName("value");
  val[0].value = "";
  val[1].value = "";
  val[2].value = "";
  val[1].style.opacity = "0";
  val[1].disabled = true;
}

function encryptBut() {
  if (ProcFlag) return;
  state = true;
  let val = document.getElementsByClassName("inputKeys")[0].style;
  val.marginTop = "20%";
  val.opacity = "1";
  val = document.getElementsByClassName("value");
  val[0].value = "";
  val[1].value = "";
  val[2].value = "";
  val[1].style.opacity = "1";
  val[1].disabled = false;
}

function getPrimeNumbers(val) {
  let Arr = [];
  let i = 2;
  while (i <= val) {
    if (val % i == 0) {
      while (val % i == 0) {
        val /= i;
      }
      Arr.push(i);
    }
    i++;
  }
  return Arr;
}

function Roots(num) {
  const temp = [];
  let buf;
  const Mult = getPrimeNumbers(num - 1);
  for (let i = 2; i < num; i++) {
    for (let j = 0; j < Mult.length; j++) {
      buf = PowerOnMod(i, ((num - 1) / Mult[j]) ^ 0, num);
      if (buf === 1) break;
      if (j === Mult.length - 1) {
        temp.push(i);
      }
    }
  }
  return temp;
}

function nextStep() {
  let val = document.getElementsByClassName("inputKeys")[0].style;
  val.marginTop = "-30%";
  val.opacity = "0";
  val = document.getElementsByClassName("value");
  if (
    Number(val[0].value) <= 255 ||
    Number(val[0].value) <= 1 ||
    Number(val[0].value) - (Number(val[0].value) ^ 0) != 0 ||
    Euler(Number(val[0].value)) != Number(val[0].value) - 1
  ) {
    alert("Введенно неверное число p");
    return;
  }

  if (
    (Number(val[1].value) <= 1 ||
      Number(val[1].value) >= Number(val[0].value) - 1 ||
      Number(val[1].value) - (Number(val[1].value) ^ 0) != 0 ||
      EuclidNOD(Number(val[1].value), Number(val[0].value) - 1) != 1) &&
    state
  ) {
    alert("Введенно неверное число k");
    return;
  }

  if (
    Number(val[2].value) <= 1 ||
    Number(val[2].value) >= Number(val[0].value) - 1
  ) {
    alert("Число x не в диапозоне 1 < x < p - 1");
    return;
  }
  let intoDiv = document.getElementById("g");
  let g = Roots(Number(val[0].value));
  if (g.length == 0) {
    alert("Первообразная g не найдена");
    return;
  } else if (state) {
    alert("Найденно " + g.length + " первообразных корня");
  }
  while (intoDiv.firstChild) {
    intoDiv.removeChild(intoDiv.firstChild);
  }
  for (let i = 0; i < g.length; i++) {
    let div = document.createElement("option");
    div.innerText = String(g[i]);
    div.value = String(g[i]);
    intoDiv.appendChild(div);
  }

  if (state) {
    [val] = document.getElementsByClassName("gBox");
    val.style.marginLeft = "40%";
    val.style.opacity = "1";
  } else decryptBeg();
  ProcFlag = true;
}

function EuclidNOD(num1, num2) {
  while (num1 != 0 && num2 != 0)
    if (num1 > num2) num1 %= num2;
    else num2 %= num1;

  return num1 + num2;
}

function PowerOnMod(value, power, mod) {
  let v = value;
  let p = power;
  let x = 1;

  while (p != 0) {
    while (p % 2 == 0) {
      p /= 2;
      v = (v * v) % mod;
    }
    p -= 1;
    x = (x * v) % mod;
  }
  return x;
}

function Euler(val) {
  let result = val;
  let n = val;
  let i = 2;
  while (i <= n) {
    if (n % i == 0) {
      while (n % i == 0) {
        n /= i;
      }
      result -= result / i;
    }
    i++;
  }

  if (n > 1) {
    result -= result / n;
  }
  return result;
}

function isPrimitiveDivider(val, n) {
  let ret = false;
  if (n % val == 0 && Euler(val) == val - 1) {
    ret = true;
  }
  return ret;
}
