function getWeekNumber(d) {
  d = new Date(`${d.month}.${d.day}.${d.year}`);
  d = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
  d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
  let yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  let weekNo = Math.ceil(((d - yearStart) / 86400000 + 1) / 7);
  return [d.getUTCFullYear(), weekNo];
}

function moodFromNumToStr(currentMoodVal) {
  const currentMood =
    currentMoodVal >= 1.5
      ? 'ideally'
      : currentMoodVal < 1.5 && currentMoodVal >= 0.5
      ? 'good'
      : currentMoodVal < 0.5 && currentMoodVal >= -0.5
      ? 'normal'
      : currentMoodVal < -0.5 && currentMoodVal >= -1.5
      ? 'bad'
      : 'awful';
  return currentMood;
}

function moodFromStrToNum(value) {
  let moodVal = 0;
  if (/ideally/gi.exec(value)) moodVal += 2;
  if (/good/gi.exec(value)) moodVal += 1;
  if (/bad/gi.exec(value)) moodVal += -1;
  if (/awful/gi.exec(value)) moodVal += -2;
  return moodVal;
}

module.exports = {
  getWeeksFromDays: (arrInJSON) => {
    let arr = JSON.parse(arrInJSON);
    let newArr = [];
    let moodVal = 0;
    let ordNumWeek;
    let count = 1;

    arr.forEach((element) => {
      let currentYearWeek = getWeekNumber(element.date);
      count++;
      if (
        newArr.length === 0 ||
        ordNumWeek[0] !== currentYearWeek[0] ||
        ordNumWeek[1] !== currentYearWeek[1]
      ) {
        if (
          newArr.length > 0 &&
          (ordNumWeek[0] !== currentYearWeek[0] ||
            ordNumWeek[1] !== currentYearWeek[1])
        ) {
          const currentMoodVal = moodVal / (count - 1);
          const currentMood = moodFromNumToStr(currentMoodVal);

          let flagSetMood = false;
          newArr[newArr.length - 1].items = newArr[newArr.length - 1].items.map(
            (e) => {
              if (e.name.toUpperCase() === 'MOOD') {
                flagSetMood = true;
                e.value = currentMood;
              }
              return e;
            }
          );

          if (!flagSetMood)
            newArr[newArr.length - 1].items.push({
              name: 'Mood',
              value: currentMood,
            });
        }
        moodVal = 0;
        count = 1;
        ordNumWeek = getWeekNumber(element.date);
        newArr.push(element);
        element.items.forEach((e) => {
          if (e.name.toUpperCase() === 'MOOD')
            moodVal += moodFromStrToNum(e.value);
        });
      } else {
        newArr[newArr.length - 1].toDate = element.date;
        newArr[newArr.length - 1].countTasks += element.countTasks;
        element.items.forEach((outElement) => {
          if (outElement.name.toUpperCase() === 'MOOD')
            moodVal += moodFromStrToNum(outElement.value);
          else {
            let flagHasItem = false;
            newArr[newArr.length - 1].items.forEach((innerElement, index) => {
              if (!flagHasItem && innerElement.name === outElement.name) {
                flagHasItem = true;
                let lineBreak = '';
                if (/^\n/.exec(outElement.value)) lineBreak = '\n';
                newArr[newArr.length - 1].items[
                  index
                ].value += `${lineBreak}${outElement.value}`;
              }
            });
            if (!flagHasItem) {
              newArr[newArr.length - 1].items.push(outElement);
            }
          }
        });
      }

      if (element === arr[arr.length - 1]) {
        const currentMoodVal = moodVal / count;
        const currentMood = moodFromNumToStr(currentMoodVal);

        let flagSetMood = false;
        newArr[newArr.length - 1].items = newArr[newArr.length - 1].items.map(
          (e) => {
            if (e.name.toUpperCase() === 'MOOD') {
              flagSetMood = true;
              e.value = currentMood;
            }
            return e;
          }
        );

        if (!flagSetMood)
          newArr[newArr.length - 1].items.push({
            name: 'Mood',
            value: currentMood,
          });
      }
    });

    return newArr;
  },
  getMonthsFromDays: (arrInJSON) => {
    let arr = JSON.parse(arrInJSON);
    let newArr = [];
    let moodVal = 0;
    let currentYear;
    let currentMonth;
    let count = 1;

    arr.forEach((element) => {
      count++;
      if (
        newArr.length === 0 ||
        currentMonth !== element.date.month ||
        currentYear !== element.date.year
      ) {
        if (
          newArr.length > 0 &&
          (currentMonth !== element.date.month ||
            currentYear !== element.date.year)
        ) {
          const currentMoodVal = moodVal / (count - 1);
          const currentMood = moodFromNumToStr(currentMoodVal);

          let flagSetMood = false;
          newArr[newArr.length - 1].items = newArr[newArr.length - 1].items.map(
            (e) => {
              if (e.name.toUpperCase() === 'MOOD') {
                flagSetMood = true;
                e.value = currentMood;
              }
              return e;
            }
          );

          if (!flagSetMood)
            newArr[newArr.length - 1].items.push({
              name: 'Mood',
              value: currentMood,
            });
        }
        moodVal = 0;
        count = 1;
        currentMonth = element.date.month;
        currentYear = element.date.year;
        newArr.push(element);
        element.items.forEach((e) => {
          if (e.name.toUpperCase() === 'MOOD')
            moodVal += moodFromStrToNum(e.value);
        });
      } else {
        newArr[newArr.length - 1].toDate = element.date;
        newArr[newArr.length - 1].countTasks += element.countTasks;
        element.items.forEach((outElement) => {
          if (outElement.name.toUpperCase() === 'MOOD')
            moodVal += moodFromStrToNum(outElement.value);
          else {
            let flagHasItem = false;
            newArr[newArr.length - 1].items.forEach((innerElement, index) => {
              if (!flagHasItem && innerElement.name === outElement.name) {
                flagHasItem = true;
                let lineBreak = '';
                if (/^\n/.exec(outElement.value)) lineBreak = '\n';
                newArr[newArr.length - 1].items[
                  index
                ].value += `${lineBreak}${outElement.value}`;
              }
            });
            if (!flagHasItem) {
              newArr[newArr.length - 1].items.push(outElement);
            }
          }
        });
      }

      if (element === arr[arr.length - 1]) {
        const currentMoodVal = moodVal / count;
        const currentMood = moodFromNumToStr(currentMoodVal);

        let flagSetMood = false;
        newArr[newArr.length - 1].items = newArr[newArr.length - 1].items.map(
          (e) => {
            if (e.name.toUpperCase() === 'MOOD') {
              flagSetMood = true;
              e.value = currentMood;
            }
            return e;
          }
        );

        if (!flagSetMood)
          newArr[newArr.length - 1].items.push({
            name: 'Mood',
            value: currentMood,
          });
      }
    });

    return newArr;
  },
  dateToFileName: (date) => {
    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();
    return `${day < 10 ? '0' + day.toString() : day.toString()}.${
      month < 10 ? '0' + month.toString() : month.toString()
    }.${year.toString()}.txt`;
  },
};
