let card = [
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,2,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,3,1],
    [1,0,1,1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,1,0,1,1,1,0,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,1,1,1,0,1,1,1,0,1,0,0,0,0,1,1,1,0,1,1,1,1,1,1],
    [1,0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1],
    [1,0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
    [1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,0,1,0,1,1,1,1,1,0,1,1],
    [1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0,0,1,1,1,0,0,0,0,0,1,1],
    [1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,1,1,0,1,1,1,0,1,1,1,1,1,1,1,1],
    [1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],
    [1,0,1,0,0,1,0,1,0,1,1,1,0,1,1,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1],
    [1,0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,1,1,1],
    [1,0,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1],
    [1,3,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
];

var selected = localStorage.getItem('selected');

let person = {
    HP: 'off',
    X: 27,
    Y: 1
};

let enemyPerson1 = {
    Direcrion: true,
    X: 1,
    Y: 6
};

let enemyPerson2 = {
    Direcrion: true,
    X: 14,
    Y: 10
};

let flagBut = false;
let flag = true;
let gameOver = false;

Draw();
let flagSmoke = true;
Smoke();
StartEnemy();

function Smoke() {
    if (flagSmoke) {
        document.getElementsByClassName('smoke')[0].style.background = 'black';
        flagSmoke = false;
        setTimeout(Smoke, 2500);
    } else {
        document.getElementsByClassName('smoke')[0].style.background = 'transparent';
        flagSmoke = true;
        setTimeout(Smoke, 16000);
    };
};

function StartEnemy() 
{
    /*--------------------------Person1----------------------------------*/
    if ((((enemyPerson1.X - 1 === person.X) && (!enemyPerson1.Direcrion)) 
       ||((enemyPerson1.X + 1 === person.X) && (enemyPerson1.Direcrion))) 
       && (enemyPerson1.Y === person.Y) && (person.HP === 'on')) showLose();
    if (enemyPerson1.Direcrion) 
    {
        enemyPerson1.X++;
        let div = document.getElementsByClassName('enemyPerson1')[0];
        div.style.marginTop = String(enemyPerson1.Y * 62.96) + 'px';
        div.style.marginLeft = String(enemyPerson1.X * 3.333 + 0.27) + '%';
        div.style.background = "url('enemyRight.png') no-repeat";
        if (enemyPerson1.X === 27) enemyPerson1.Direcrion = false; 
    }
    else
    {
        enemyPerson1.X--;
        let div = document.getElementsByClassName('enemyPerson1')[0];
        div.style.marginTop = String(enemyPerson1.Y * 62.96) + 'px';
        div.style.marginLeft = String(enemyPerson1.X * 3.333 + 0.27) + '%';
        div.style.background = "url('enemyLeft.png') no-repeat";
        if (enemyPerson1.X === 1) enemyPerson1.Direcrion = true; 
    };
    /*-------------------------------------------------------------------*/
    /*--------------------------Person2----------------------------------*/
    if ((((enemyPerson2.Y + 1 === person.Y) && (!enemyPerson2.Direcrion)) 
       ||((enemyPerson2.Y - 1 === person.Y) && (enemyPerson2.Direcrion))) 
       && (enemyPerson2.X === person.X) && (person.HP === 'on')) showLose();
    if (enemyPerson2.Direcrion) 
    {
        enemyPerson2.Y--;
        let div = document.getElementsByClassName('enemyPerson2')[0];
        div.style.marginTop = String(enemyPerson2.Y * 62.96) + 'px';
        div.style.marginLeft = String(enemyPerson2.X * 3.333 + 0.27) + '%';
        div.style.background = "url('enemyBehind.png') no-repeat";
        if (enemyPerson2.Y === 1) enemyPerson2.Direcrion = false; 
    }
    else
    {
        enemyPerson2.Y++;
        let div = document.getElementsByClassName('enemyPerson2')[0];
        div.style.marginTop = String(enemyPerson2.Y * 62.96) + 'px';
        div.style.marginLeft = String(enemyPerson2.X * 3.333 + 0.27) + '%';
        div.style.background = "url('enemyFront.png') no-repeat";
        if (enemyPerson2.Y === 10) enemyPerson2.Direcrion = true; 
    };
    /*-------------------------------------------------------------------*/
    
    if (!gameOver) setTimeout(StartEnemy, 150);  
};

function Draw() {
    let div;
    let map;
    for (let d = 0; d < 16; d++)
        for (let i = 0; i < 30; i++)
        {
            div = document.createElement('div');
            map = document.createElement('div');
            if (card[d][i] === 0){
                div.className = 'way';
                map.className = 'mapWay';
            };
            if (card[d][i] === 1){
                div.className = 'wall';
                map.className = 'mapWall';
            };
            if (card[d][i] === 2){
                div.className = 'elevator';
                map.className = 'elevatorMap';
            };
            if (card[d][i] === 3){
                div.className = 'stairs';
                map.className = 'stairsMap';
            };
            document.body.append(div);
            div = document.getElementsByClassName('Map')[0];
            map.innerHTML = '';
            div.appendChild(map);
        };
    div = document.createElement('div');
    map = document.createElement('div');
    div.className = 'person';
    map.className = 'mapPerson';
    
    div.style.marginTop = String(person.Y * 62.96) + 'px';
    div.style.marginLeft = String(person.X * 3.333 + 0.27) + '%';
    map.style.marginTop = String(person.Y * 8) + 'px';
    map.style.marginLeft = String(person.X * 8) + 'px';

    document.body.append(div);
    div.style.opacity = '0.4';
    div.style.transition = '0s';

    div = document.getElementsByClassName('Map')[0];
    map.innerHTML = '';
    div.appendChild(map); 

    div = document.createElement('div');
    div.className = 'enemyPerson1';
    div.style.marginTop = String(enemyPerson1.Y * 62.96) + 'px';
    div.style.marginLeft = String(enemyPerson1.X * 3.333 + 0.27) + '%';
    document.body.append(div);

    div = document.createElement('div');
    div.className = 'enemyPerson2';
    div.style.marginTop = String(enemyPerson1.Y * 62.96) + 'px';
    div.style.marginLeft = String(enemyPerson1.X * 3.333 + 0.27) + '%';
    document.body.append(div);
};

function gg() {
    location.href = 'main.html'
};

function showLose() {
    let temp = document.getElementsByClassName('msg')[0];
    temp.textContent = 'Вас словила стража. Вы проиграли';
    temp.style.fontSize = '55px';
    temp = document.getElementsByClassName('showMessage')[0];
    temp.style.border = '2px solid red';
    temp.style.marginTop = '20%';
    temp.style.opacity = '1';
    gameOver = true;
    setTimeout(gg, 5000);
};

function showWin() {
    let temp = document.getElementsByClassName('msg')[0];
    temp.textContent = 'Вы выйграли';
    temp = document.getElementsByClassName('showMessage')[0];
    temp.style.marginTop = '20%';
    temp.style.opacity = '1';
    gameOver = true;
    setTimeout(gg, 5000);
};

document.addEventListener('keydown', function(event) {
    if (flagBut || gameOver) return;
    setTimeout(onBut, 300);
    if (!flag) flagBut = true;

    if ((flag && ((event.code === 'Enter') || (selected === "true")))) {
        localStorage.setItem('selected', true);
        document.getElementsByClassName('person')[0].remove();
        let div = document.createElement('div');
        div.className = 'person';
        div.style.marginTop = String(person.Y * 62.96) + 'px';
        div.style.marginLeft = String(person.X * 3.333 + 0.27) + '%';
        document.body.append(div);
        document.getElementsByClassName('mapPerson')[0].style.transition = '0.4s';
        flag = false;   
        person.HP = 'on';
    };

    switch (event.code) {
        case 'KeyS':
            if (((person.Y + 1) === 14) && (person.X === 28)) location.href = "secondfloor.html"; 
            if (((person.Y + 1) === 14) && (person.X === 1)) showWin();
            if (card[person.Y + 1][person.X] === 0) person.Y++;
            break;
    
        case 'KeyW':
            if (((person.Y - 1) === 1) && (person.X === 1)) location.href = "tirdfloor.html";
            if (card[person.Y - 1][person.X] === 0) person.Y--;
            break;

        case 'KeyD':
            if ((person.Y === 14) && ((person.X + 1) === 28)) location.href = "secondfloor.html";
            if ((person.Y === 1) && ((person.X + 1) === 28)) showLose();
            if (card[person.Y][person.X + 1] === 0) person.X++;
            break;
        
        case 'KeyA':
            if ((person.Y=== 1) && ((person.X - 1) === 1)) location.href = "tirdfloor.html";
            if ((person.Y === 14) && ((person.X - 1) === 1)) showWin();
            if (card[person.Y][person.X - 1] === 0) person.X--;
            break;

        default: return;
    };

    DrawPersone();

    switch (event.code) {
    case 'KeyS':
        document.getElementsByClassName('person')[0].style.background = "url('front.png') no-repeat";
        break;

    case 'KeyW':
            document.getElementsByClassName('person')[0].style.background = "url('behind.png') no-repeat";
        break;

    case 'KeyD':
            document.getElementsByClassName('person')[0].style.background = "url('right.png') no-repeat";
        break;
    
    case 'KeyA':
            document.getElementsByClassName('person')[0].style.background = "url('left.png') no-repeat";
        break;
    };
});

function DrawPersone() {
    div = document.getElementsByClassName('person')[0];
    div.style.marginTop = String(person.Y * 62.96) + 'px';
    div.style.marginLeft = String(person.X * 3.333 + 0.27) + '%';
    
    div = document.getElementsByClassName('mapPerson')[0];
    div.style.marginTop = String(person.Y * 8) + 'px';
    div.style.marginLeft = String(person.X * 8) + 'px';
};

function onBut() {
    flagBut = false;
};