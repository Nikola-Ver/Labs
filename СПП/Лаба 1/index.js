const express = require('express');
const app = express();
const port = 4000;

app
    .set('view engine', 'ejs')
    
    .use(express.static(__dirname + '/views/styles'))

    .get('/', (req, res) => {
        const val = "val";
        res.render('pages/index', { val });
    })

    .listen(port);