module.exports = {
  parseData: (data) => {
    const items = [...data.matchAll(/[^\n0-9]+?:/gm)].map((e) => {
      return e[0].replace(':', '').trim();
    });
    const itemsWithVal = [];
    let countTasks = 0;

    if (items.length > 0) {
      items.reduce((current, next) => {
        const regExp = new RegExp(`(?<=${current}:)[^]*(?=${next}:)`, 'g');
        itemsWithVal.push({ name: current, value: data.match(regExp)[0] });
        return next;
      });

      const regExpForLast = new RegExp(
        `(?<=${items[items.length - 1]}:)[^]*`,
        'g'
      );
      itemsWithVal.push({
        name: items[items.length - 1],
        value: data.match(regExpForLast)[0],
      });
      if (data.match(/^-/gm)) countTasks = data.match(/^-/gm).length;
    }

    return { items: itemsWithVal, countTasks };
  },
  parseToDate: (data) => {
    let fileData = '';
    data.forEach((e) => {
      if (e.name.length !== 0) fileData += `${e.name}:${e.value}`;
    });
    return fileData;
  },
};
