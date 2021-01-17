let CL;

function InsertExplosion()
{
  let div = document.createElement("div");
  div.className = "Explosion";
  document.getElementsByClassName("BorderTextArea")[1].appendChild(div);

}

function DepthOper(Code)
{
    Code = Code.value;
    let valideCode = Code.replace(/""".*?"""/gis, "");
    valideCode = valideCode.replace(/#.*/gi, "");
    valideCode = valideCode.replace(/^ *(?![a-z0-9]| )/gim, "");
    console.log(valideCode);
    let ConditionOper = valideCode.match(/(^ +)|(?<![a-z0-9$_])for((?=\()|(?= ))+|(?<![a-z0-9$_])while((?=\()|(?= ))+|(?<![a-z0-9$_])else((?=:|(?= ))+)|(?<![a-z0-9$_])elif((?=:|(?= ))+)|(?<![a-z0-9$_])if((?=\()|(?= ))+/gim);
    console.log(ConditionOper);
    let CLI = 0;
    let CurrLevel = -1;
    let Space = [ConditionOper[0]];
    ConditionOper.forEach(element => {
        if (element.search(/if|for|while|else|elif/i) > -1)
        {
            CurrLevel++;
            if (CurrLevel > CLI) CLI = CurrLevel;
        }
        else
            if (Space[Space.length - 1].length < element.length) 
            {
                Space.push(element);
            }
            else 
            {
                if (Space[Space.length - 1].length > element.length)
                {
                    while ((CurrLevel > -1) && (Space[Space.length - 1].length > element.length))    
                    {
                        Space.pop();
                        CurrLevel--;
                    };
                    Space.push(element);
                }
            }
    });
    console.log(CLI);
    return CLI;
}

function QuantityOper(Code)
{
    Code = Code.value;
    let valideCode = Code.replace(/""".*?"""/gis, "");
    valideCode = valideCode.replace(/#.*/gi, "");
    console.log(valideCode);
    let Operators = valideCode.match(/(?<![a-z0-9$_])elif((?=\()|(?= ))+|(?<![a-z0-9$_])print((?=\()|(?= ))+|-=|\+=|\^=|&=|\|=|\/=|\*=|(?<=([a-z0-9 ]))=(?=([a-z ]))|(?<![a-z0-9$_])if((?=\()|(?= ))+|(?<![a-z0-9$_])for((?=\()|(?= ))+|(?<![a-z0-9$_])while((?=\()|(?= ))+|(?<![a-z0-9$_])break(?![a-z0-9$_])|(?<![a-z0-9$_])continue(?![a-z0-9$_])/gi);    
    CL = valideCode.match(/(?<![a-z0-9$_])elif((?=\()|(?= ))+|(?<![a-z0-9$_])if((?=\()|(?= ))+|(?<![a-z0-9$_])for((?=\()|(?= ))+|(?<![a-z0-9$_])while((?=\()|(?= ))+/gim);
    console.log(Operators.length, CL.length, CL, Operators);
    CL = CL.length;
    return Operators.length;
}

// Дальше визуальная часть

function LoadBut() {
  document.getElementsByClassName("load")[0].click();
};

document.getElementsByClassName("load")[0].addEventListener('change', function(){
  var fr = new FileReader();
  fr.onload = function() {
    document.getElementsByClassName('TextArea')[0].value = this.result;
};
fr.readAsText(this.files[0]);
});

function ResultBut() {
  let val = document.getElementsByClassName("BorderTextArea")[1];
  val.style.marginLeft = "2%";
  val.style.height = "850px";
  val.style.border = "3px solid";
  val.style.width = "40%";
  [val] = document.getElementsByClassName("BorderTextArea");
  val.style.marginLeft = "9%";
  try 
  {
    let CLI = QuantityOper(document.getElementsByClassName("TextArea")[0]);
        CLI = DepthOper(document.getElementsByClassName("TextArea")[0]);
    document.getElementsByClassName("TextArea")[1].value = "CL = " + String(CL) + ", cl = " + String(CL/QuantityOper(document.getElementsByClassName("TextArea")[0])) +
        " (количество операторов программы равно " + String(QuantityOper(document.getElementsByClassName("TextArea")[0])) + "), CLI = " + String(CLI) + ".";
  }
  catch (err)
  {
    document.getElementsByClassName("TextArea")[1].value = "Произошла ошибка";
    setTimeout(InsertExplosion, 500);
  }
}

function CloseBut() {
  let [val] = document.getElementsByClassName("BorderTextArea");
  val.style.marginLeft = "30%";
  val = document.getElementsByClassName("BorderTextArea")[1];
  val.style.marginLeft = "29%";
  val.style.height = "0";
  val.style.border = "0";
  val.style.width = "0";
  document.getElementsByClassName("TextArea")[1].value = "";
  if (document.getElementsByClassName("Explosion")[0] !== undefined) 
    document.getElementsByClassName("Explosion")[0].remove();
}