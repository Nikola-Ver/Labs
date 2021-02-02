const express = require('express');
const app = express();
const port = 4000;

const data = [];

app
    .set('view engine', 'ejs')
    
    .use(express.static(__dirname + '/views/styles'))

    .get('/', (req, res) => {
        res.render('pages/index', { data });
    })

    .listen(port);