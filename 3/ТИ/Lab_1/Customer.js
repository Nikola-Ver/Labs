var errorflag = true;
var igif = 0;

let gif = document.getElementsByClassName("headtext")[0];
gif.onmouseover = function(event) {
  if (igif === 0) {
    gif = document.getElementsByClassName("gif")[0];
    gif.style.background = "url(cat.gif)";
    igif++;
  } else {
    gif = document.getElementsByClassName("gif")[0];
    gif.style.background = "url(pika.gif)";
    igif--;
  }
};

gif.onmouseout = function(event) {
  gif = document.getElementsByClassName("gif")[0];
  gif.style.background = "transparent";
};

let loadD = document.getElementsByClassName("VvodD")[0];
let butD = document.getElementsByClassName("InputD")[0];
let wordD = loadD.value;
loadD.ondragover = function(event) {
  loadD.value = "\n\n\n\n\n\n\n\n\nОтпустите файл чтобы считать текст";
  loadD.style.background = "rgb(255, 255, 255)";
  loadD.style.color = "black";
  butD.removeAttribute("style");
  butD.style.zIndex = 1;
};

butD.ondragleave = function(event) {
  loadD.removeAttribute("style");
  loadD.value = wordD;
  butD.removeAttribute("style");
  butD.value = "";
  butD.style.zIndex = 0;
};

butD.addEventListener("change", function() {
  var fr = new FileReader();
  fr.onload = function() {
    console.log(fr);
    loadD.value = this.result;
  };

  fr.readAsText(this.files[0]);
  butD.removeAttribute("style");
  butD.style.zIndex = 0;
  loadD.removeAttribute("style");
  butD.value = "";
});

let loadE = document.getElementsByClassName("VvodE")[0];
let butE = document.getElementsByClassName("InputE")[0];
let wordE = loadE.value;
loadE.ondragover = function(event) {
  wordE = loadE.value;
  loadE.value = "\n\n\n\n\n\n\n\n\nОтпустите файл чтобы считать текст";
  loadE.style.background = "rgb(255, 255, 255)";
  loadE.style.color = "black";
  butE.removeAttribute("style");
  butE.style.zIndex = 1;
};

butE.ondragleave = function(event) {
  loadE.removeAttribute("style");
  loadE.value = wordE;
  butE.removeAttribute("style");
  butE.value = "";
  butE.style.zIndex = 0;
};

butE.addEventListener("change", function() {
  var fr = new FileReader();
  fr.onload = function() {
    console.log(fr);
    loadE.value = this.result;
  };

  fr.readAsText(this.files[0]);
  butE.removeAttribute("style");
  butE.style.zIndex = 0;
  loadE.removeAttribute("style");
  butE.value = "";
});

function isInteger(num) {
  return (num ^ 0) === num;
}

function reload() {
  window.location.href = "Customer.html";
}

function closebutE() {
  let temp = document.getElementsByClassName("VivodE")[0];
  temp.value = "";
  temp.style.background = "transparent";
  temp.style.height = "0px";
  temp.style.zIndex = -1;

  temp = document.getElementsByClassName("closeVivodE")[0];
  temp.disabled = "true";
  temp.style.background = "transparent";
  temp.style.zIndex = -1;
  temp = document.getElementsByClassName("saveE")[0];
  temp.style.background = "transparent";
  temp.style.zIndex = -1;
}

function closebutD() {
  let temp = document.getElementsByClassName("VivodD")[0];
  temp.value = "";
  temp.style.background = "transparent";
  temp.style.height = "0px";
  temp.style.zIndex = -1;

  temp = document.getElementsByClassName("closeVivodD")[0];
  temp.disabled = "true";
  temp.style.background = "transparent";
  temp.style.zIndex = -1;
  temp = document.getElementsByClassName("saveD")[0];
  temp.style.background = "transparent";
  temp.style.zIndex = -1;
}

function CheckStr(stroka) {
  stroka = stroka.match(/[A-Z]/gi); // Без пробела
  // stroka = stroka.match(/[A-Z]| /gi);      // С пробелом
  if (stroka != null) stroka = stroka.join("");

  return stroka;
}

function encode() {
  let val = document.getElementsByClassName("VivodE")[0];
  val.style.background = "white";
  val.style.height = "650px";
  val.style.zIndex = 1;

  val = document.getElementsByClassName("closeVivodE")[0];
  val.style.background = "url(close.png)";
  val.style.zIndex = 1;
  val = document.getElementsByClassName("saveE")[0];
  val.style.background = "url('save.png') no-repeat";
  val.style.zIndex = 1;

  let temp = document.getElementsByClassName("choose")[0];
  val = document.getElementsByClassName("VvodE")[0];
  switch (temp.selectedIndex) {
    case 0:
      {
        val = CheckStr(val.value);
        temp = document.getElementsByClassName("VivodE")[0];
        if (val != null) {
          var StrLen = val.length;
          temp = RailwayFence(StrLen);
        }
        OutputE(val, StrLen, temp);
      }
      break;

    case 1:
      {
        val = CheckStr(val.value);
        temp = document.getElementsByClassName("VivodE")[0];
        if (val != null) {
          var StrLen = val.length;
          temp = Column(StrLen);
        }
        OutputE(val, StrLen, temp);
      }
      break;

    case 2:
      {
        if (val != null) temp = Vizhener(val.value, true);

        if (!errorflag) {
          val = document.getElementsByClassName("VivodE")[0];
          val.value = temp;
        } else {
          val = document.getElementsByClassName("VivodE")[0];
          val.value = "Ошибка...";
        }
      }
      break;
  }
}

function RailwayFence(len) {
  errorflag = true;
  let str = prompt("Введите высоту (ключ)");
  let num = Number(str);
  str = prompt(
    'Введите направление железнодорожной изгороди\n("вверх" или "вниз")'
  );
  if (str === null || num === null) return;
  let dictionary;
  let i, j;

  if (str.toLowerCase() === "вниз" && num > 1) {
    errorflag = false;
    dictionary = true;
    j = 0;
  }

  if (str.toLowerCase() === "вверх" && num > 1) {
    errorflag = false;
    dictionary = false;
    j = num - 1;
  }

  if (!errorflag && isInteger(num)) {
    let StrArr = [];
    for (i = 0; i < len; i++) StrArr[i] = i;
    i = 0;

    let arr = Array.from(Array(num), () => new Array(len));

    while (i < len) {
      if (!dictionary) {
        arr[j][i] = StrArr[i];
        j--;
        i++;
        if (j < 0) {
          dictionary = true;
          j += 2;
        }
      }

      if (dictionary) {
        arr[j][i] = StrArr[i];
        j++;
        i++;
        if (j >= num) {
          dictionary = false;
          j -= 2;
        }
      }
    }

    i = 0;
    for (let d = 0; d < num; d++)
      for (let k = 0; k < len; k++)
        if (arr[d][k] != undefined) {
          StrArr[i] = arr[d][k];
          i++;
        }

    return StrArr;
  }
}

function decode() {
  let val = document.getElementsByClassName("VivodD")[0];
  val.style.background = "white";
  val.style.height = "650px";
  val.style.zIndex = 1;

  val = document.getElementsByClassName("closeVivodD")[0];
  val.style.background = "url(close.png)";
  val.style.zIndex = 1;
  val = document.getElementsByClassName("saveD")[0];
  val.style.background = "url('save.png') no-repeat";
  val.style.zIndex = 1;

  let temp = document.getElementsByClassName("choose")[0];
  val = document.getElementsByClassName("VvodD")[0];
  switch (temp.selectedIndex) {
    case 0:
      {
        val = CheckStr(val.value);
        temp = document.getElementsByClassName("VivodD")[0];
        if (val != null) {
          var StrLen = val.length;
          temp = RailwayFence(StrLen);
        }
        OutputD(val, StrLen, temp);
      }
      break;

    case 1:
      {
        val = CheckStr(val.value);
        temp = document.getElementsByClassName("VivodD")[0];
        if (val != null) {
          var StrLen = val.length;
          temp = Column(StrLen);
        }
        OutputD(val, StrLen, temp);
      }
      break;

    case 2:
      {
        if (val != null) temp = Vizhener(val.value, false);

        if (!errorflag) {
          val = document.getElementsByClassName("VivodD")[0];
          val.value = temp;
        } else {
          val = document.getElementsByClassName("VivodD")[0];
          val.value = "Ошибка...";
        }
      }
      break;
  }
}

function Column(len) {
  errorflag = true;
  let key = prompt("Введите ключевое слово (ключ)");
  if (key === null) return;

  key = key.toLowerCase();
  key = key.match(/[A-Z]/gi);
  const AlphabetMas = "abcdefghijklmnopqrstuvwxyz".split("");
  let arr = [];

  if (key != null) {
    errorflag = false;
    let d = 0;
    let mas = [];
    AlphabetMas.forEach(function(letter) {
      for (let i = 0; i < key.length; i++) {
        if (letter === key[i].toLowerCase()) {
          mas[i] = d;
          d++;
        }
      }
    });

    let i = 0;
    let index;
    for (d = 0; d < key.length; d++) {
      index = mas.findIndex(elem => (elem === d ? true : false));
      while (index < len) {
        arr[i] = index;
        index += key.length;
        i++;
      }
    }
  }

  return arr;
}

function Vizhener(val, flag) {
  errorflag = false;
  const AlphabetMas = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя".split("");
  const BigAlphabetMas = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    .toLocaleUpperCase()
    .split("");
  let key = prompt("Введите ключевое слово (ключ)");
  if (key === null) {
    errorflag = true;
    return;
  }
  key = key.match(/[А-Я]|Ё/gi);
  // val = val.match(/[А-Я]|Ё/gi);       // Без пробела
  val = val.match(/[А-Я]|Ё| /gi); // С пробелом
  let option = prompt(
    'Выберите тип ключа ("прямой ключ", "прогрессивный ключ", "самогенерирующийся ключ")'
  );
  if (key === null || val === null || option === null) {
    errorflag = true;
    return;
  }

  let lenKey = key.join("").length;
  let skip = 0;

  //-------------Создание ключей----------------//
  if (option.toLowerCase() === "прямой ключ") {
    if (key.length >= val.length)
      key.splice(val.length, key.length - val.length);
    else
      for (let i = 0; i < val.length - lenKey; i++) key.push(key[i % lenKey]);
  } else if (option.toLowerCase() === "прогрессивный ключ") {
    if (key.length >= val.length)
      key.splice(val.length, key.length - val.length);
    else {
      AlphabetMas.forEach(function(elem) {
        if (elem === " ") skip++;
      });
      let shift = 1;
      for (let i = 0; i < val.length - lenKey - skip; i++) {
        let index = AlphabetMas.findIndex(elem =>
          elem === key[i % lenKey] ? true : false
        );
        key.push(AlphabetMas[(index + shift) % 33]);
        if (i % lenKey === lenKey - 1) shift++;
      }
      skip = 0;
    }
  } else if (option.toLowerCase() === "самогенерирующийся ключ") {
    if (key.length >= val.length)
      key.splice(val.length, key.length - val.length);
    else if (flag)
      for (let i = 0; i < val.length - lenKey + skip; i++) {
        if (
          AlphabetMas.findIndex(elem =>
            elem === val[i % val.length] ? true : false
          ) != -1
        )
          key.push(val[i % val.length]);
        else skip++;
      }
    else
      for (let i = 0; i < val.length - lenKey + skip; i++) {
        const index = AlphabetMas.findIndex(elem =>
          elem === val[i % val.length] ? true : false
        );
        if (index != -1) {
          const shift = AlphabetMas.findIndex(elem =>
            elem === key[i - skip] ? true : false
          );
          key.push(AlphabetMas[Math.abs(33 + index - shift) % 33]);
        } else skip++;
      }
  } else {
    errorflag = true;
    return;
  }
  lenKey = key.length;
  skip = 0;

  //-----------Шифровка и дешифровка-----------//
  if (flag) {
    for (let i = 0; i < lenKey; i++) {
      let shift = AlphabetMas.findIndex(elem =>
        elem === val[i % val.length] ? true : false
      );

      if (shift != -1) {
        const index = AlphabetMas.findIndex(elem =>
          elem === key[i - skip].toLowerCase() ? true : false
        );
        val[i] = AlphabetMas[(shift + index) % 33];
      } else {
        shift = BigAlphabetMas.findIndex(elem =>
          elem === val[i % val.length] ? true : false
        );
        if (shift != -1) {
          const index = BigAlphabetMas.findIndex(elem =>
            elem === key[i - skip].toUpperCase() ? true : false
          );
          val[i] = BigAlphabetMas[(shift + index) % 33];
        } else {
          val[i] = " ";
          skip++;
        }
      }
    }
  } else {
    for (let i = 0; i < lenKey; i++) {
      let index = AlphabetMas.findIndex(elem =>
        elem === val[i % val.length] ? true : false
      );

      if (index != -1) {
        const shift = AlphabetMas.findIndex(elem =>
          elem === key[i - skip].toLowerCase() ? true : false
        );
        val[i] = AlphabetMas[Math.abs(33 + index - shift) % 33];
      } else {
        index = BigAlphabetMas.findIndex(elem =>
          elem === val[i % val.length] ? true : false
        );
        if (index != -1) {
          const shift = BigAlphabetMas.findIndex(elem =>
            elem === key[i - skip].toUpperCase() ? true : false
          );
          val[i] = BigAlphabetMas[Math.abs(33 + index - shift) % 33];
        } else {
          val[i] = " ";
          skip++;
        }
      }
    }
  }

  return val.join("");
}

function OutputE(val, StrLen, temp) {
  if (!errorflag) {
    let mas = val.split("");
    let arr = [];
    for (let i = 0; i <= StrLen; i++)
      if (mas[temp[i]] != undefined) arr[i] = mas[temp[i]];

    val = "";
    for (let i = 0; i <= StrLen; i++) if (arr[i] != undefined) val += arr[i];

    temp = document.getElementsByClassName("VivodE")[0];
    temp.value = val;
  } else {
    val = document.getElementsByClassName("VivodE")[0];
    val.value = "Ошибка...";
  }
}

function OutputD(val, StrLen, temp) {
  if (!errorflag) {
    let mas = val.split("");
    let arr = [];
    for (let i = 0; i <= StrLen; i++)
      if (mas[i] != undefined) arr[temp[i]] = mas[i];

    val = "";
    for (let i = 0; i <= StrLen; i++) if (arr[i] != undefined) val += arr[i];

    temp = document.getElementsByClassName("VivodD")[0];
    temp.value = val;
  } else {
    val = document.getElementsByClassName("VivodD")[0];
    val.value = "Ошибка...";
  }
}

function download(filename, text) {
  var pom = document.createElement("a");
  pom.setAttribute(
    "href",
    "data:text/plain;charset=utf-8," + encodeURIComponent(text)
  );

  pom.setAttribute("download", filename);

  pom.style.display = "none";
  document.body.appendChild(pom);

  pom.click();

  document.body.removeChild(pom);
}
