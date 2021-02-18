const express = require('express');
const app = express();
const PORT = 80;
const path = require('path');
const fs = require('fs');
const parserDate = require('./parserDate');
const parserData = require('./parserData');
const pathToTasks = require('./pathToTasks.json');

let tasks = [[], [], []]; // days, weeks, months

function updateTasks(flag) {
  tasks = [[], [], []];
  fs.readdir(pathToTasks, (err, files) => {
    files.forEach((file) => {
      const filePath = path.join(pathToTasks, file);
      const date = file.match(/[0-9]+(?=\.)/g).map((e) => Number.parseInt(e));
      tasks[0].push(
        Object.assign(
          {},
          parserData.parseData(`${fs.readFileSync(filePath)}`),
          {
            date: {
              day: date[0],
              month: date[1],
              year: date[2],
            },
            toDate: {
              day: date[0],
              month: date[1],
              year: date[2],
            },
          }
        )
      );
    });
    tasks[0].sort(
      (current, next) =>
        Number.parseInt(
          current.date.year.toString() +
            (current.date.month.toString().length < 2
              ? `0${current.date.month.toString()}`
              : current.date.month.toString()) +
            (current.date.day.toString().length < 2
              ? `0${current.date.day.toString()}`
              : current.date.day.toString())
        ) -
        Number.parseInt(
          next.date.year.toString() +
            (next.date.month.toString().length < 2
              ? `0${next.date.month.toString()}`
              : next.date.month.toString()) +
            (next.date.day.toString().length < 2
              ? `0${next.date.day.toString()}`
              : next.date.day.toString())
        )
    );
    tasks[1] = parserDate.getWeeksFromDays(JSON.stringify(tasks[0]));
    tasks[2] = parserDate.getMonthsFromDays(JSON.stringify(tasks[0]));
  });
}

updateTasks();

app.use(express.static(path.join(__dirname, '../front/build')));
app.use(express.json());
app
  .get('*', async (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(tasks));
  })

  .put('*', async (req, res) => {
    let day = new Date();
    while (
      fs.existsSync(path.join(pathToTasks, parserDate.dateToFileName(day)))
    ) {
      day.setDate(day.getDate() + 1);
    }
    fs.writeFileSync(
      path.join(pathToTasks, parserDate.dateToFileName(day)),
      ''
    );
    updateTasks();
    res.setHeader('Content-Type', 'application/json');
    res.end();
  })

  .delete('*', async (req, res) => {
    tasks[0].splice(req.body.index, 1);
    fs.unlinkSync(path.join(pathToTasks, req.body.file));
    updateTasks();
    res.setHeader('Content-Type', 'application/json');
    res.end();
  })

  .post('*', async (req, res) => {
    tasks[0][req.body.index] = JSON.parse(req.body.item);
    if (tasks[0][req.body.index].date !== tasks[0][req.body.index].toDate) {
      fs.unlinkSync(path.join(pathToTasks, req.body.file));
      tasks[0][req.body.index].date = Object.assign(
        {},
        tasks[0][req.body.index].toDate
      );
      req.body.file = `${
        tasks[0][req.body.index].date.day < 10
          ? `0${tasks[0][req.body.index].date.day.toString()}`
          : tasks[0][req.body.index].date.day
      }.${
        tasks[0][req.body.index].date.month < 10
          ? `0${tasks[0][req.body.index].date.month.toString()}`
          : tasks[0][req.body.index].date.month
      }.${tasks[0][req.body.index].date.year}.txt`;
    }
    fs.writeFileSync(
      path.join(pathToTasks, req.body.file),
      parserData.parseToDate(JSON.parse(req.body.item).items)
    );

    updateTasks();
    res.setHeader('Content-Type', 'application/json');
    res.end();
  })

  .listen(PORT);
