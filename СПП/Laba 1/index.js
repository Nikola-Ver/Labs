const express = require('express');
const app = express();
const port = 1234;

app.set('view engine', 'ejs');

app.get('/', function(req, res) {
    res.render('pages/index');
});


app.listen(port);