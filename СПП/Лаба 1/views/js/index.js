const [dragElement] = document.getElementsByClassName('ondrag-file');
const [form] = document.getElementsByClassName('form');
const [file] = document.getElementsByClassName('file');
const [fileButton] = document.getElementsByClassName('file-button');
const [text] = document.getElementsByClassName('text');
const [sendButton] = document.getElementsByClassName('send-button');
const [header] = document.getElementsByClassName('main-header');

const todoItems = document.getElementsByClassName('todo-item');
const deleteItem = document.getElementsByClassName('delete-todo');
const doneItem = document.getElementsByClassName('done-item');
const filesTodoOpen = document.getElementsByClassName('files-todo');
const filesTodoClose = document.getElementsByClassName('close-files-item');
const filesItems = document.getElementsByClassName('files-item');

const filesData = [];

if (todoItems)
    for (let i = 0; i < todoItems.length; i++) {
        doneItem[i].onclick = e => {
            new Promise ((res, rej) => {
                todoItems[i].classList.toggle('done');
                setTimeout(() => { res() }, 200);
            }).then (() => {
                fetch('/', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        item: i
                    })
                }).then(() => {
                    window.location.reload();
                })
            })
        }

        deleteItem[i].onclick = e => {
            fetch('/', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    item: i
                })
            }).then(() => {
                window.location.reload();
            })
        }

        filesTodoOpen[i].onclick = e => {
            filesItems[i].classList.add('open')
        }

        filesTodoClose[i].onclick = e => {
            filesItems[i].classList.remove('open')
        }
    }

function changeColorFunc() {
    function getCookie(name) {
        let matches = document.cookie.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    let background = 'black';
    let text = 'white';

    if (getCookie('--main-color-background') && getCookie('--main-color-text')) {
        text = getCookie('--main-color-text');
        background = getCookie('--main-color-background');
        document.documentElement.style.setProperty('--main-color-background', background);
        document.documentElement.style.setProperty('--main-color-text', text);
        if (background === 'white') document.documentElement.style.setProperty('--invert-val', '0');
    }

    return function () {
        const temp = text;
        text = background;
        background = temp;

        document.documentElement.style.setProperty('--main-color-background', background);
        document.documentElement.style.setProperty('--main-color-text', text);

        document.cookie = `--main-color-background=${background}`;
        document.cookie = `--main-color-text=${text}`;

        if (background === 'white') document.documentElement.style.setProperty('--invert-val', '0');
        else document.documentElement.style.setProperty('--invert-val', '1');
    }
}

const changeColor = changeColorFunc();

header.onclick = e => {
    changeColor();
}

form.ondragenter = e => {
    dragElement.style.display = 'flex';
}

dragElement.ondragleave = e => {
    dragElement.style.display = 'none';
}

dragElement.ondragover = e => {
    e.preventDefault();
}

dragElement.ondrop = e => {
    e.preventDefault();
    dragElement.style.display = 'none';

    for (let i = 0; i < e.dataTransfer.files.length; i++) {
        const name = e.dataTransfer.files[i].name;
        let content;

        const fr = new FileReader();
        fr.onload = function () {
            content = this.result;
            filesData.push({ name, content });
            fileButton.title = filesData.map(e => e.name).join('\n');
        };

        if (name.match(/\.txt$/)) fr.readAsText(e.dataTransfer.files[i]);
    }
}

fileButton.onclick = e => {
    text.focus();
    file.click();
}

file.addEventListener('change', function () {
    const name = this.files[0].name;
    let content;

    const fr = new FileReader();
    fr.onload = function () {
        content = this.result;
        filesData.push({ name, content });
        fileButton.title = filesData.map(e => e.name).join('\n');
    };

    if (name.match(/\.txt$/)) fr.readAsText(this.files[0]);
})

sendButton.onclick = e => {
    fetch('/', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            text: text.value,
            files: filesData,
            done: ''
        })
    }).then(() => {
        window.location.reload();
    })
}