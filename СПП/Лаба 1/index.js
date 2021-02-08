const express = require('express');
const app = express();
const port = 4000;

const data = [];

app
    .use(express.static(__dirname + '/views/css'))
    .use(express.static(__dirname + '/views/js'))
    .use(express.static(__dirname + '/views/img'))

    .use(express.json({ limit: '50mb' }))
    .use(express.urlencoded({ limit: '50mb' }))

    .put('/', (req, res) => {
        data.push(req.body);
        res.status(200).end();
    })

    .delete('/', (req, res) => {
        data.splice(req.body.item, 1);
        res.status(200).end();
    })

    .post('/', (req, res) => {
        if (data[req.body.item].done.length > 0) {
            data[req.body.item].done = ''
        } else {
            data[req.body.item].done = 'done'
        }
        res.status(200).end();
    })

    .set('view engine', 'ejs')

    .get('/', (req, res) => {
        res.render('pages/index', { data });
    })

    .listen(port);
